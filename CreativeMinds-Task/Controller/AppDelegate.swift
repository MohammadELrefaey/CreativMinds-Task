//
//  AppDelegate.swift
//  CreativeMinds-Task
//
//  Created by Mohamed on 5/25/21.
//

import UIKit
import MOLH
@main
class AppDelegate: UIResponder, UIApplicationDelegate, MOLHResetable {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        MOLH.shared.activate(true)
        reset()
        return true
    }
    
    // resetting app function to reset language
    func reset() {
        let rootViewController: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let story = UIStoryboard(name: "Main", bundle: nil)
        rootViewController.rootViewController = story.instantiateViewController(withIdentifier: "HomeVC")
    }


}

