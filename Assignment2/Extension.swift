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
