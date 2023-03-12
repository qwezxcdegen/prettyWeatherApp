//
//  CurrentWeatherData.swift
//  prettyWeatherApp
//
//  Created by Степан Фоминцев on 08.03.2023.
//

import Foundation

struct CurrentWeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
    let feels_like: Double
}

struct Weather: Decodable {
    let id: Int
}
