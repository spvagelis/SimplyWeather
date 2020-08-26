//
//  WeatherApi.swift
//  SimplyWeather
//
//  Created by vagelis spirou on 20/8/20.
//  Copyright © 2020 vagelis spirou. All rights reserved.
//

import Foundation


struct WeatherApi {
    
func fetchCurrentWeather(completion: @escaping WeatherResponseCompletion) {
    
    print("The current weather: \(CURRENT_WEATHER_URL)")
    guard let url = URL(string: CURRENT_WEATHER_URL) else { return }
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        
        if error != nil {
            debugPrint(error!.localizedDescription)
            completion(nil)
            return
        }
        
        guard let data = data else {
            print("I couldn't unwrap the data")
            completion(nil)
            return
        }
        print("Data : \(String(data: data, encoding: .utf8))")
        if let weather1 = self.parseJSON(weatherData: data) {
            
            DispatchQueue.main.async {
                completion(weather1)
            }
        }
    }
    
    task.resume()
}
    
    func parseJSON(weatherData: Data) -> CurrentWeather? {
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(CurrentWeather.self, from: weatherData)
            return decodedData
            
        } catch {
            print("error: \(error)")
            return nil
        }
        
    }
}

