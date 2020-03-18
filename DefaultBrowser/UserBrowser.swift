//
//  UserBrowser.swift
//  DefaultBrowser
//
//  Created by Janne Lehikoinen on 9.3.2020.
//  Copyright © 2020 Janne Lehikoinen. All rights reserved.
//

import SwiftUI

// Model for user installed browsers data
struct UserBrowser: Hashable, Codable, Identifiable {
    
    var id = UUID()
    var displayName: String
    var urlSchemeHandler: String
    var isDefault: Bool
}

extension UserBrowser {
    
    static let iconWidth = 40.0
    static let iconHeight = 40.0
    
    // Convert app icon to SwiftUI Image view
    var icon: Image {
        let appIcon: NSImage = NSWorkspace.shared.icon(forFile: self.path)
        appIcon.size = NSSize(width: UserBrowser.iconWidth, height: UserBrowser.iconHeight)
        return Image(nsImage: appIcon)
    }
    
    var path: String {
        return NSWorkspace.shared.absolutePathForApplication(withBundleIdentifier: urlSchemeHandler)!
    }
    
    var version: String {
        let appBundle = Bundle.init(path: path)
        guard let appVersion = appBundle?.object(forInfoDictionaryKey: "CFBundleShortVersionString") else {
            return "0.0"
        }
        return appVersion as! String
    }
}
