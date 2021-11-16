//
//  AppCoordinator.swift
//  CalendarApp-MVVM
//

import Foundation
import UIKit


protocol Coordinator {
    func start() -> UIViewController
}

final class AppCoordinator : Coordinator {
    private var window : UIWindow?
    
    init(window : UIWindow) {
        self.window = window
    }
    
    var rootViewController: UINavigationController!
    @discardableResult
    func start()-> UIViewController {
        let loginCoodinator = LoginCoordinator()
        let mainVC = loginCoodinator.start() as? LoginViewController
        rootViewController = UINavigationController(rootViewController: mainVC!)
        loginCoodinator.rootViewController = rootViewController
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
        return mainVC!
    }
}
