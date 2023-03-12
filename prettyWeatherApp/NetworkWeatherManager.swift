//
//  NetworkWeatherManager.swift
//  prettyWeatherApp
//
//  Created by Степан Фоминцев on 08.03.2023.
//

import Foundation
import CoreLocation

struct NetworkWeatherManager {
    func fetchCurrentWeather(forCity city: String, completionHandler: @escaping (CurrentWeather) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiKey)&units=metric"
        guard let url = URL(string: urlString.encodeUrl) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data {
                if let currentWeather = self.parseJSON(withData: data) {
                    completionHandler(currentWeather)
                }
            }
        }
        task.resume()
    }
    
    func fetchCurrentWeather(forLatitude latitude: CLLocationDegrees, longitude: CLLocationDegrees, completionHandler: @escaping (CurrentWeather) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString.encodeUrl) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data {
                if let currentWeather = self.parseJSON(withData: data) {
                    completionHandler(currentWeather)
                }
            }
        }
        task.resume()
    }
    
    
    fileprivate func parseJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else { return nil }
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
