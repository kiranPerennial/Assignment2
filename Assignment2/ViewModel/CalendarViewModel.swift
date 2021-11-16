import Foundation
import EventKit
import RxSwift

class CalendarViewModel {
    let updateEvent = PublishSubject<EKEvent>()
    let logOutUser = PublishSubject<Void>()
    let createNewEvent = PublishSubject<(Date)>()
    let completeEditing = PublishSubject<Void>()
    
    func createNewEvent(_ date:Date) {
        self.createNewEvent.onNext(date)
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
}
