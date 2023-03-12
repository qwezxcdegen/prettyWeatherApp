//
//  CurrentWeather.swift
//  prettyWeatherApp
//
//  Created by Степан Фоминцев on 08.03.2023.
//

import Foundation

struct CurrentWeather {
    let cityName: String
    let temperature: Double
    var temperatureString: String {
        String(Int(temperature.rounded()))
    }
    let feelsLikeTemperature: Double
    var feelsLikeTemperatureString: String {
        String(Int(feelsLikeTemperature.rounded()))
    }
    let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232: return "cloud.bolt.rain"
        case 300...321: return "cloud.drizzle"
        case 500...531: return "cloud.rain"
        case 600...622: return "cloud.snow"
        case 701...781: return "smoke"
        case 800: return "sun.max"
        case 801...804: return "cloud"
        default: return "nosign"
        }
    }
    
    init?(currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLikeTemperature = currentWeatherData.main.feels_like
        conditionCode = currentWeatherData.weather.first!.id
    }
}
