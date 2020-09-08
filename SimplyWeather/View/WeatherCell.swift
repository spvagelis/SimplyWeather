//
//  WeatherCell.swift
//  SimplyWeather
//
//  Created by vagelis spirou on 26/8/20.
//  Copyright © 2020 vagelis spirou. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    

    func updateCellUI(forecast: Forecast?, for indexPath: IndexPath) {
        
        if let forecast = forecast {
        DispatchQueue.main.async {
            self.minTemp.text = String(format: "%.0f", forecast.list[indexPath.row].temp.min)
            self.maxTemp.text = String(format: "%.0f", forecast.list[indexPath.row].temp.max)
            let timeStamp = forecast.list[indexPath.row].dt
            self.dayLabel.text = self.getDateFromTimeStamp(timeStamp: timeStamp)
            let iconImageName = forecast.list[indexPath.row].weather[0].icon
            self.weatherIcon.image = UIImage(named: iconImageName)
            self.weatherType.text = forecast.list[indexPath.row].weather[0].main
            
        }
        }
        
        
    }
    
    func getDateFromTimeStamp(timeStamp: Double) -> String {
        
        let date = NSDate(timeIntervalSince1970: timeStamp)

        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "EEEE"

        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
        
        
    }

}
