//
//  WeatherAppUIApp.swift
//  WeatherAppUI
//
//  Created by David Adewale on 10/07/2024.
//

import SwiftUI

@main
struct WeatherAppUIApp: App {
    
    @State private var appState = AppUIState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appState)
        }
    }
}
