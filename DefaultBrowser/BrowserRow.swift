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
        HStack(spacing: 30) {
            // Default browser style
            if userBrowser.isDefault {
                userBrowser.icon
                Text(userBrowser.displayName)
                    .fontWeight(.bold)
                    .font(.system(.body, design: .rounded))
                Text("⭐️")
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Path: \(userBrowser.path)")
                    Text("Version: \(userBrowser.version)")
                }
            } else {
                // Row selected style
                if selectedBrowserHandler == userBrowser.urlSchemeHandler {
                    userBrowser.icon
                    Text(userBrowser.displayName)
                        .fontWeight(.bold)
                        .font(.system(.body, design: .rounded))
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Path: \(userBrowser.path)")
                        Text("Version: \(userBrowser.version)")
                    }
                // Rest of the rows
                } else {
                    userBrowser.icon.opacity(0.5)
                    Text(userBrowser.displayName).opacity(0.5)
                    .font(.system(.body, design: .rounded))
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Path: \(userBrowser.path)")
                        Text("Version: \(userBrowser.version)")
                    }
                    .opacity(0.5)
                }
            }
        }.padding(5)
        .frame(height: 50)
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
