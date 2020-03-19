//
//  ContentView.swift
//  DefaultBrowser
//
//  Created by Janne Lehikoinen on 29.2.2020.
//  Copyright © 2020 Janne Lehikoinen. All rights reserved.
//

 /// MARK: TODO
/*
 - Custom button style? Separate button style view?
 - Animations?
 - Padding on left side and bottom of list on light mode?
*/

import SwiftUI

// "Main" view
struct ContentView: View {
    
    // This is for modifying default browser isDefault values in UserBrowser array
    @EnvironmentObject var userSettings: UserSettings
    // This is for transfering selected row info to BrowserRow child view
    @State var selectedBrowserHandler: String? = nil
    var body: some View {
        VStack {
            Text("Select default browser")
            List {
                ForEach(userSettings.userBrowsers) { item in
                    BrowserRow(userBrowser: item, selectedBrowserHandler: self.$selectedBrowserHandler)
                    .onTapGesture {
                        print("User selected: \(item.displayName) (\(item.urlSchemeHandler))")
                        self.userSettings.selectedHandler = item.urlSchemeHandler
                        self.selectedBrowserHandler = item.urlSchemeHandler
                    }
                }
            }
            Button(action: self.saveSettingsButtonClicked) {
                Text("Save settings")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func saveSettingsButtonClicked() {
        
        let dataHelper = DataHelper()
        dataHelper.setDefaultScheme(scheme: DataHelper.schemeHttp, handler: userSettings.selectedHandler!)
        dataHelper.setDefaultScheme(scheme: DataHelper.schemeHttps, handler: userSettings.selectedHandler!)
        userSettings.setDefaultBrowserBoolValue(newHandler: userSettings.selectedHandler!)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserSettings())
//            .environment(\.colorScheme, .light)
    }
}
