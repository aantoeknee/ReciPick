//
//  ReciPickApp.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/21/26.
//

import SwiftUI

@main
struct ReciPickApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}
