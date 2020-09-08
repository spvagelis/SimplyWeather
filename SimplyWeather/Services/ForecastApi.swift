//
//  ForecastApi.swift
//  SimplyWeather
//
//  Created by vagelis spirou on 26/8/20.
//  Copyright © 2020 vagelis spirou. All rights reserved.
//

import Foundation

struct ForecastApi {
    
    func fetchForecast(completion: @escaping ForecastResponseCompletion) {
        
        print("The forecast weather: \(FORECAST_URL)")
        guard let url = URL(string: FORECAST_URL) else { return }
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
            
            print("Data from forecast: \(String(data: data, encoding: .utf8))")
            
            if let forecast = self.parseJson(forecastData: data) {
                
                DispatchQueue.main.async {
                    completion(forecast)
                }
            }
        }
        
        task.resume()
    }
    
    func parseJson(forecastData: Data) -> Forecast? {
        
        let decoder = JSONDecoder()
        
        do {
            
            let decodedData = try decoder.decode(Forecast.self, from: forecastData)
            return decodedData
            
        } catch {
            print("error: \(error)")
            return nil
        }
        
    }
    
}
