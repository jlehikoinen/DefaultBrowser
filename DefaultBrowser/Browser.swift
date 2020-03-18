//
//  Browser.swift
//  DefaultBrowser
//
//  Created by Janne Lehikoinen on 29.2.2020.
//  Copyright © 2020 Janne Lehikoinen. All rights reserved.
//

import Cocoa

// Model for included json file data
struct Browser: Hashable, Codable {
    
    let displayName: String
    let urlSchemeHandler: String
}
