//
//  Weather.swift
//  WeatherAppUI
//
//  Created by David Adewale on 10/07/2024.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: Weather
}


struct Weather: Decodable {
    let temp: Double
}
