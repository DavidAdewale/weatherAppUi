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
    @State private var isFetchingWeather: Bool = false
    
    let geocodingClient = GeocodingClient()
    
    var body: some View {
        @Bindable var appState = appState
        
        VStack {
            TextField("City", text: $appState.city)
                .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        isFetchingWeather = true
            
                    }.task(id: isFetchingWeather) {
                        if isFetchingWeather {
                           await  fetchWeather()
                            isFetchingWeather = false
                            appState.city = ""
                        }
                }
            
            if(isFetchingWeather == true){
            ProgressView("Loading...")
        }
            
        Spacer()
            
        if let temp = appState.temp {
            Text(MeasurementFormatter.temperature(value: temp))
                .font(.system(size: 100))
        }
        
        Spacer()
        }.padding()
        
    }
        
    
    private func fetchWeather() async {
        do {
            guard let location = try await geocodingClient.coordinateByCity(appState.city) else { return }
            let weather = try await geocodingClient.weatherByLatLon(location.lat, location.lon)
            appState.temp = weather
        } catch {
            print(error)
        }
    }
    
    /*
    
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
     */
    
}



#Preview {
    ContentView()
        .environment(AppUIState())
}
