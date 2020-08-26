//
//  Location.swift
//  SimplyWeather
//
//  Created by vagelis spirou on 20/8/20.
//  Copyright © 2020 vagelis spirou. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    
    static var sharedInstance = Location()
    
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
    
}
