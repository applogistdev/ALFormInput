//
//  AppDelegate.swift
//  ALFormInput
//
//  Created by sonifex on 04/13/2020.
//  Copyright (c) 2020 sonifex. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Set global configurations like below for all ALValidatableTextField's
        ALTextFieldConfig.shared.errorColor = .red
        
        return true
    }

}

