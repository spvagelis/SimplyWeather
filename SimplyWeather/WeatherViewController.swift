//
//  WeatherViewController.swift
//  SimplyWeather
//
//  Created by vagelis spirou on 19/8/20.
//  Copyright © 2020 vagelis spirou. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentConditionWeatherLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    var weather = WeatherApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath)
        return cell
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        locationAuthStatus()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        locationAuthStatus()
        
    }
    
    func locationAuthStatus() {
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            currentLocation = locationManager.location!
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            print(Location.sharedInstance.latitude)
            
            weather.fetchCurrentWeather { currentWeather in
                
                if let currentWeather = currentWeather {
                    
                    self.updateUI(currentWeather: currentWeather)
                    
                }
            }
        } else {
            
            locationManager.requestWhenInUseAuthorization()
            
        }
    }
    
    
    func getDateFromTimeStamp(timeStamp : Double) -> String {

        let date = NSDate(timeIntervalSince1970: timeStamp)

        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "EEEE, dd MMMM YYYY"

        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
    
    func updateUI(currentWeather: CurrentWeather) {
        
        print("current = \(currentWeather)")
        let iconImageName = currentWeather.weather[0].icon
        self.currentWeatherImage.image = UIImage(named: iconImageName)
        let timeStamp = currentWeather.date
        let dateInString = self.getDateFromTimeStamp(timeStamp: timeStamp)
        self.dateLabel.text = dateInString
        self.currentTempLabel.text = String(currentWeather.main.temp)
        self.cityNameLabel.text = currentWeather.cityName
        self.currentConditionWeatherLabel.text = currentWeather.weather[0].description
        
    }
}

