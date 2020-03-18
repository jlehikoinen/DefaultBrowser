//
//  DataHelper.swift
//  DefaultBrowser
//
//  Created by Janne Lehikoinen on 29.2.2020.
//  Copyright © 2020 Janne Lehikoinen. All rights reserved.
//

import Cocoa

let dataHelper = DataHelper()
// Handle json file
let browserListData: [Browser] = dataHelper.loadJsonFromFile("browsers.json")
// Get user installed browsers
let userBrowserData = dataHelper.getInstalledBrowsers(browserList: browserListData)

// Collection of helper methods
struct DataHelper {
    
    static let schemeHttp = "http"
    static let schemeHttps = "https"
    
    func isDefaultBrowser(urlSchemeHandler: String) -> Bool {
        
        let currentUrlSchemeHandler = self.getDefaultURLSchemeHandler(targetScheme: DataHelper.schemeHttps)
        
        if currentUrlSchemeHandler == urlSchemeHandler {
            print("Current \(DataHelper.schemeHttps) scheme handler: \(currentUrlSchemeHandler)")
            return true
        }
        return false
    }
    
    // Also checks default browser and updates it to [UserBrowser] data
    func getInstalledBrowsers(browserList: [Browser]) -> [UserBrowser] {
        
        var userBrowsers = [UserBrowser]()
        var installedUtiHandlers = [String]()

        // Deprecation warning noted, would need to change app logic to utilize LSCopyApplicationURLsForURL()
        guard let cfArray = LSCopyAllHandlersForURLScheme(DataHelper.schemeHttps as CFString)?.takeRetainedValue() else {
            return userBrowsers
        }
        
        // Cast from CFArray to NSArray
        if let cfArrayAsNSArray = cfArray as? NSArray {
            // Cast from NSArray to Swift array
            installedUtiHandlers = cfArrayAsNSArray as! [String]
            // print(installedUtiHandlers)
        }

        // Get common browsers comparing browserListData and installedUtiHandlers
        for item in browserListData {
            if installedUtiHandlers.contains(item.urlSchemeHandler) {
                var userBrowser = UserBrowser(displayName: item.displayName, urlSchemeHandler: item.urlSchemeHandler, isDefault: false)
                if self.isDefaultBrowser(urlSchemeHandler: item.urlSchemeHandler) {
                    userBrowser.isDefault = true
                }
                userBrowsers.append(userBrowser)
            }
        }
        // print(userBrowsers)
        return userBrowsers
    }
    
    func getDefaultURLSchemeHandler(targetScheme: String) -> String {
        
        var urlSchemeHandler = ""
        // Deprecation warning noted, would need to change app logic to utilize LSCopyDefaultApplicationURLForURL()
        if let appScheme = LSCopyDefaultHandlerForURLScheme(targetScheme as CFString) {
            urlSchemeHandler = appScheme.takeRetainedValue() as String
        }
        return urlSchemeHandler
    }

    func setDefaultScheme(scheme: String, handler: String) {
        
        print("Changing \(scheme) URL scheme handler to \(handler)")
        LSSetDefaultHandlerForURLScheme(scheme as CFString, handler as CFString)
    }
    
    // Source: https://developer.apple.com/tutorials/swiftui/creating-a-macos-app
    func loadJsonFromFile<T: Decodable>(_ filename: String) -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
