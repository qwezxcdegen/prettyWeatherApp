//
//  String+Extension.swift
//  prettyWeatherApp
//
//  Created by Степан Фоминцев on 08.03.2023.
//

import Foundation

import UIKit
extension String {
    var encodeUrl : String
    {
        self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decodeUrl : String
    {
        self.removingPercentEncoding!
    }
}
