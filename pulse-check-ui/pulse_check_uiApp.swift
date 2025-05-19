//
//  pulse_check_uiApp.swift
//  pulse-check-ui
//
//  Created by Baden Bennett on 5/19/25.
//

import SwiftUI

@main
struct pulse_check_uiApp: App {
    @StateObject var sessionManager = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            if sessionManager.isAuthenticated {
                ContentView().environmentObject(sessionManager)
            } else {
                LoginView().environmentObject(sessionManager)
            }
        }
    }
}
