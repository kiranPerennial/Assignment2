import Foundation
import EventKit
import RxSwift

class CalendarViewModel {
    var user: User?
    let updateEvent = PublishSubject<EKEvent>()
    let logOutUser = PublishSubject<Void>()
    let createNewEvent = PublishSubject<(EKWrapper)>()
    let completeEditing = PublishSubject<Void>()
    
    func createNewEvent(_ date:Date, eventStore: EKEventStore) {
        let newEKEvent = EKEvent(eventStore: eventStore)
        newEKEvent.calendar = eventStore.defaultCalendarForNewEvents
        newEKEvent.url = URL(string: user!.email)
        var components = DateComponents()
        components.hour = 1
        
        let endDate = Calendar.current.date(byAdding: .hour, value: 1, to: date)//calenderViewController.calendar.date(byAdding: components, to: date)
        
        newEKEvent.startDate = date
        newEKEvent.endDate = endDate
        newEKEvent.title = "New event"
        
        let newEKWrapper = EKWrapper(eventKitEvent: newEKEvent)
        newEKWrapper.editedEvent = newEKWrapper
        self.createNewEvent.onNext(newEKWrapper)
    }
    
    func updateNewEvent(ekEvent: EKEvent) {
        self.updateEvent.onNext(ekEvent)
    }
    
    func didTapCompleteEditing() {
        self.completeEditing.onNext(Void())
    }
    
    func didTapOnLogout() {
        self.logOutUser.onNext(Void())
    }
    
    func filterEvent(_ str: String) -> Bool {
        return str == user?.email || str == ""
    }
}
