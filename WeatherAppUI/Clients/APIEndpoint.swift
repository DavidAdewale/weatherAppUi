//
//  APIEndpoint.swift
//  WeatherAppUI
//
//  Created by David Adewale on 10/07/2024.
//

import Foundation

enum APIEndpoint {
    
    static let baseURL = "https://api.openweathermap.org"
    // 👆🏽 making baseURL a static let makes the baseURL a property of the APIEndpoint itself. This means that other elements can access the exact baseURL by just saying APIEndpoint.baseURL
    
    case coordinatesByLocationName(String)
    case weatherByLatLon(Double, Double)
    
    private var path: String {
        switch self {
        case .coordinatesByLocationName(let city):
            return "/geo/1.0/direct?q=\(city)&appid=\(Constants.Keys.weatherAPIKey)"
        case .weatherByLatLon(let lat, let lon):
            return "/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(Constants.Keys.weatherAPIKey)"
        }
    }
    
    static func endpointURL(for endpoint: APIEndpoint) -> URL {
        let endpointPath = endpoint.path
        print(baseURL + endpointPath)
        return URL(string: baseURL + endpointPath)!
    }
}
