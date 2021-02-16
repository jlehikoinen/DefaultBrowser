//
//  ContentView.swift
//  DefaultBrowser
//
//  Created by Janne Lehikoinen on 29.2.2020.
//  Copyright © 2020 Janne Lehikoinen. All rights reserved.
//

 /// MARK: TODO
/*
 - userSettings.setDefaultBrowserBoolValue => UserBrowser calculated property or some other solution?
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
                .fontWeight(.bold)
                .font(.system(.largeTitle, design: .rounded))
            List {
                ForEach(userSettings.userBrowsers) { item in
                    BrowserRow(userBrowser: item, selectedBrowserHandler: self.$selectedBrowserHandler)
                    .onTapGesture {
                        print("User selected: \(item.displayName) (\(item.urlSchemeHandler))")
                        self.userSettings.selectedHandler = item.urlSchemeHandler
                        self.selectedBrowserHandler = item.urlSchemeHandler
                    }
                    .listRowBackground(self.userSettings.selectedHandler == item.urlSchemeHandler ? Color(red: 145 / 255, green: 190 / 255, blue: 255 / 255).opacity(0.3) : nil)
                    }
            }.cornerRadius(8)
            .padding(.bottom, 10)
            Button(action: self.saveSettingsButtonClicked) {
                Text("Save settings")
            }
            .disabled(userSettings.selectedHandler == nil ? true : false)
        }
        .padding()
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
