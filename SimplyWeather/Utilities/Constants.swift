//
//  Constants.swift
//  SimplyWeather
//
//  Created by vagelis spirou on 20/8/20.
//  Copyright © 2020 vagelis spirou. All rights reserved.
//

import Foundation

let BASE_URL = "https://api.openweathermap.org/data/2.5/weather?"
let CURRENT_WEATHER_URL = "\(BASE_URL)lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&units=metric&appid=1f1e005331f60221e4aa6cea480b74ea"

typealias WeatherResponseCompletion = (CurrentWeather?) -> Void
    


