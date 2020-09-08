//
//  Forecast.swift
//  SimplyWeather
//
//  Created by vagelis spirou on 26/8/20.
//  Copyright © 2020 vagelis spirou. All rights reserved.
//

import UIKit

struct Forecast: Codable {
    
    let list: [List]
    
}

struct List: Codable {
    
    let dt: Double
    let temp: Temp
    let weather: [ForecastWeather]
    
}

struct Temp: Codable {
    
    let min: Double
    let max: Double
    
    
}

struct ForecastWeather: Codable {
    
    let icon: String
    let main: String
    
}
