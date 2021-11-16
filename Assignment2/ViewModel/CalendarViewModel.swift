import Foundation
import EventKit
import RxSwift

class CalendarViewModel {
    let updateEvent = PublishSubject<EKEvent>()
    let logOutUser = PublishSubject<Void>()
    let createNewEvent = PublishSubject<(Date)>()
    let addNewEvent = PublishSubject<EKEvent>()
    
    func createNewEvent(_ date:Date) {
        self.createNewEvent.onNext((date))
    }
    
    func updateNewEvent(ekEvent: EKEvent) {
        self.updateEvent.onNext(ekEvent)
    }
    
    func addNewEvent(ekEvent: EKEvent) {
        self.addNewEvent.onNext(ekEvent)
    }
    
    func didTapOnLogout() {
        self.logOutUser.onNext(Void())
    }
}
