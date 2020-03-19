//
//  BrowserRow.swift
//  DefaultBrowser
//
//  Created by Janne Lehikoinen on 29.2.2020.
//  Copyright © 2020 Janne Lehikoinen. All rights reserved.
//

import SwiftUI

// Row view
struct BrowserRow: View {
    
    var userBrowser: UserBrowser
    // This is for receiving selected row info from ContentView parent view
    @Binding var selectedBrowserHandler: String?
    
    var body: some View {
        HStack {
            Text(userBrowser.displayName)
        }
    }
}

struct BrowserRow_Previews: PreviewProvider {
    static var previews: some View {
        // Sample data
        Group {
            BrowserRow(userBrowser: userBrowserData[0], selectedBrowserHandler: .constant("com.apple.Safari"))
            BrowserRow(userBrowser: userBrowserData[1], selectedBrowserHandler: .constant("com.google.Chrome"))
        }
        .previewLayout(.fixed(width: 550, height: 80))
    }
}
