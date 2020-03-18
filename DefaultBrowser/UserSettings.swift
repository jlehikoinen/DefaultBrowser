//
//  UserSettings.swift
//  DefaultBrowser
//
//  Created by Janne Lehikoinen on 9.3.2020.
//  Copyright © 2020 Janne Lehikoinen. All rights reserved.
//

import SwiftUI

// View model for sharing data between views
final class UserSettings: ObservableObject {
    
    @Published var userBrowsers = userBrowserData
    @Published var selectedHandler: String?
    
    // Modify default browser isDefault values in UserBrowser array "userBrowsers"
    func setDefaultBrowserBoolValue(newHandler: String) {
        
        var newArray = [UserBrowser]()
        
        for var item in userBrowsers {
            item.isDefault = item.urlSchemeHandler == newHandler ? true : false
            newArray.append(item)
        }
        // Better solution for handling the array? This is because class is a reference type?
        userBrowsers = newArray
        // print(newArray)
    }
}
