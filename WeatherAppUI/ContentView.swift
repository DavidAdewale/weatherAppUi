//
//  ContentView.swift
//  WeatherAppUI
//
//  Created by David Adewale on 10/07/2024.
//

//e4209ed26276adc0df0674e42d0f89c4

import SwiftUI

struct ContentView: View {
    @Environment(AppUIState.self) private var appState: AppUIState
    
    let geocodingClient = GeocodingClient()
    
    var body: some View {
        @Bindable var appState = appState
        
            TextField("Enter city name", text: $appState.city)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onSubmit {
                    fetchWeather()
                }.padding()
    
        if let temp = appState.temp {
            Text("\(temp.formatted()) ºF")
                .font(.largeTitle)
        }
        
        Spacer()
    }
    
    private func fetchWeather() {
        Task {
            guard let location = try? await geocodingClient.coordinateByCity(appState.city) else {
                print("Failed to fetch coordinated for \(appState.city)")
                return
            }
            
            guard let temp = try? await geocodingClient.weatherByLatLon(location.lat, location.lon) else {
                print("Failed to fetch temperature for \(appState.city)")
                return
            }
            appState.temp = temp
        }
    }
    
}



#Preview {
    ContentView()
        .environment(AppUIState())
}
