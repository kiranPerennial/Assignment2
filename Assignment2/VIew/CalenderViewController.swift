import UIKit
import CalendarKit
import EventKit
import EventKitUI

class CalenderViewController: DayViewController , EKEventEditViewDelegate{
    
    var eventStore = EKEventStore()
    var viewModel: CalendarViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAccessToCalendar()
        subscribeToNotifications()
        setupUI()
    }
    
    private func requestAccessToCalendar() {
        // Request access to the events
        eventStore.requestAccess(to: .event) { [weak self] granted, error in
            // Handle the response to the request.
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.initializeStore()
                self.subscribeToNotifications()
                self.reloadData()
            }
        }
    }
    
    private func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(storeChanged(_:)),
                                               name: .EKEventStoreChanged,
                                               object: eventStore)
    }
    
    private func initializeStore() {
        eventStore = EKEventStore()
    }
    
    @objc private func storeChanged(_ notification: Notification) {
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isToolbarHidden = true
    }
    
    func setupUI() {
        self.navigationController?.toolbar.isHidden = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: false)
        let logoutBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(actionLogoutUser))
        self.navigationItem.leftBarButtonItem  = logoutBarButtonItem
        let createEventBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: #selector(actionCreateNewEvent))
        createEventBarButtonItem.image = UIImage(systemName: "plus")
        self.navigationItem.rightBarButtonItem  = createEventBarButtonItem
    }
    
    @objc func actionLogoutUser() {
        viewModel.didTapOnLogout()
    }
    
    override func eventsForDate(_ date: Date) -> [EventDescriptor] {
        // The `date` always has it's Time components set to 00:00:00 of the day requested
        let startDate = date
        var oneDayComponents = DateComponents()
        oneDayComponents.day = 1
        // By adding one full `day` to the `startDate`, we're getting to the 00:00:00 of the *next* day
        let endDate = calendar.date(byAdding: oneDayComponents, to: startDate)!
        
        let predicate = eventStore.predicateForEvents(withStart: startDate, // Start of the current day
                                                      end: endDate, // Start of the next day
                                                      calendars: nil) // Search in all calendars
        
        let eventKitEvents = eventStore.events(matching: predicate) // All events happening on a given day
        let calendarKitEvents = eventKitEvents.map(EKWrapper.init)
        
        return calendarKitEvents
    }
    
    override func dayViewDidSelectEventView(_ eventView: EventView) {
        guard let ckEvent = eventView.descriptor as? EKWrapper else {
            return
        }
        viewModel.updateNewEvent(ekEvent: ckEvent.ekEvent)
    }
    
    // MARK: Event Editing
    
    override func dayView(dayView: DayView, didTapTimelineAt date: Date) {
        endEventEditing()
    }
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        endEventEditing()
        reloadData()
        viewModel.didTapCompleteEditing()
    }
    
    @objc func actionCreateNewEvent() {
        endEventEditing()
        viewModel.createNewEvent(Date())
    }
}

