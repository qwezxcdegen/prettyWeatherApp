//
//  ViewController.swift
//  prettyWeatherApp
//
//  Created by Степан Фоминцев on 08.03.2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var weatherIconImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    var networkWeatherManager = NetworkWeatherManager()
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        lm.requestWhenInUseAuthorization()
        return lm
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.requestLocation()
            }
        }
        
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(
            withTitle: "Введите название города",
            message: nil,
            style: .alert) { cityName in
                self.networkWeatherManager.fetchCurrentWeather(forCity: cityName) { currentWeather in
                    DispatchQueue.main.async {
                        self.temperatureLabel.text = currentWeather.temperatureString
                        self.feelsLikeTemperatureLabel.text = currentWeather.feelsLikeTemperatureString
                        self.weatherIconImage.image = UIImage(systemName: currentWeather.systemIconNameString)
                        self.cityLabel.text = cityName
                    }
                }
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        networkWeatherManager.fetchCurrentWeather(forLatitude: latitude, longitude: longitude) { currentWeather in
            DispatchQueue.main.async {
                self.temperatureLabel.text = currentWeather.temperatureString
                self.feelsLikeTemperatureLabel.text = currentWeather.feelsLikeTemperatureString
                self.weatherIconImage.image = UIImage(systemName: currentWeather.systemIconNameString)
                self.cityLabel.text = currentWeather.cityName
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
