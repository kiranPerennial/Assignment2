//
//  Extension.swift
//  CalendarApp-MVVM
//


import Foundation
import UIKit
extension StoryboardInitializable where Self:Coordinator {
    static func instantiateViewController(storyboardName:StoryBoardName,identifier:String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}

extension UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    func showAlert(title: String, message: String) {
        let viewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        viewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(viewController, animated: true, completion: nil)
    }
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
            let passwordReg = "^.{5,}$";
            // Add Password regex "^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$" .. Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character: "^.{5,}$";
            let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordReg)
            return passwordPred.evaluate(with: self)
        }
}

extension Date {
    
    func getOneHourPlusTime() -> Date {
        return Calendar.current.date(
          byAdding: .hour,
          value: +1,
            to: self) ?? Date()
    }
    
    func getDateOnly() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let month = dateFormatter.string(from: self)
        return month
    }
    
    func getMonth() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let month = dateFormatter.string(from: self)
        return month
    }
    
    func getFirstAndLastDay() -> (firstDate:Date, LastDate:Date) {
        let calendar = Calendar.current
        let date = self

        // Get first day of month
        let firstDayComponents = calendar.dateComponents([.year, .month], from: date)
        let firstDay = calendar.date(from: firstDayComponents)!

        // Get last day of month
        let lastDayComponents = DateComponents(month: 1, day: -1)
        let lastDay = calendar.date(byAdding: lastDayComponents, to: firstDay)!
        
        let dateFormatter = DateFormatter()
        //dateFormatter.locale = Locale(identifier: "en_UK")
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
        
        return(firstDay,lastDay)
    }
}
