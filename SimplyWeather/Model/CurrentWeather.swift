//
//  CurrentWeather.swift
//  SimplyWeather
//
//  Created by vagelis spirou on 20/8/20.
//  Copyright © 2020 vagelis spirou. All rights reserved.
//

import Foundation

struct CurrentWeather: Codable {
    
    let cityName: String
    let date: Double
    let main: Main
    let weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case cityName = "name"
        case date = "dt"
        case main
        case weather
    }
    
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {

    let description: String
    let icon: String
    
}
