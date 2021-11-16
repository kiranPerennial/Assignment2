import Foundation
import UIKit
import EventKit
import EventKitUI
import RxSwift

class CalendarCoordinator: Coordinator , StoryboardInitializable {
    var rootViewController: UINavigationController!
    var calenderViewController: CalenderViewController!
    let disposeBag = DisposeBag()
    
    func start() -> UIViewController {
        calenderViewController = CalenderViewController()
        let viewModel = CalendarViewModel()
        viewModel.createNewEvent.subscribe(onNext: { [weak self] in self?.createNewEvent(date: $0)
        }).disposed(by: disposeBag)
        viewModel.updateEvent.subscribe(onNext: { [weak self] in self?.updateEvent(event: $0)
        }).disposed(by: disposeBag)
        viewModel.logOutUser.subscribe(onNext: {[weak self] in
            self?.logoutUser()
        }).disposed(by: disposeBag)
        viewModel.completeEditing.subscribe(onNext: {[weak self] in
            self?.completeEditing()
        }).disposed(by: disposeBag)
        calenderViewController.viewModel = viewModel
        return calenderViewController
    }
}

extension CalendarCoordinator {
    
    func updateEvent(event: EKEvent) {
        let eventController = EKEventViewController()
        eventController.event = event
        eventController.allowsCalendarPreview = true
        eventController.allowsEditing = true
        rootViewController.pushViewController(eventController,
                                                 animated: true)
    }
    
    func logoutUser() {
        self.rootViewController.popViewController(animated: true)
    }
    
    func completeEditing() {
        self.rootViewController.dismiss(animated: true, completion: nil)
    }
    
    func createNewEvent(date: Date) {
        let newEKEvent = EKEvent(eventStore: calenderViewController.eventStore)
        newEKEvent.calendar = calenderViewController.eventStore.defaultCalendarForNewEvents
        
        var components = DateComponents()
        components.hour = 1
        let endDate = calenderViewController.calendar.date(byAdding: components, to: date)
        
        newEKEvent.startDate = date
        newEKEvent.endDate = endDate
        newEKEvent.title = "New event"
        
        let newEKWrapper = EKWrapper(eventKitEvent: newEKEvent)
        newEKWrapper.editedEvent = newEKWrapper
    
        calenderViewController.create(event: newEKWrapper, animated: true)
        
        let eventEditViewController = EKEventEditViewController()
        eventEditViewController.event = newEKWrapper.ekEvent
        eventEditViewController.eventStore = calenderViewController.eventStore
        eventEditViewController.editViewDelegate = calenderViewController
        rootViewController.present(eventEditViewController, animated: true, completion: nil)
    }
}
