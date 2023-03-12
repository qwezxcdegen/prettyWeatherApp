//
//  VC+AlertController.swift
//  prettyWeatherApp
//
//  Created by Степан Фоминцев on 08.03.2023.
//

import Foundation
import UIKit


extension ViewController {
    func presentSearchAlertController(withTitle title: String, message: String?, style: UIAlertController.Style, completionHandler: @escaping (String) -> Void) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        
        ac.addTextField { tf in
            let cities = ["Москва", "Сочи", "Новосибирск", "Екатеринбург"]
            tf.placeholder = cities.randomElement()
        }
        let search = UIAlertAction(title: "Поиск", style: .default) { action in
            guard let cityName = ac.textFields?.first?.text else { return }
            if cityName != "" {
                completionHandler(cityName)
            }
        }
        let cancel = UIAlertAction(title: "Отменить", style: .cancel)
        
        ac.addAction(search)
        ac.addAction(cancel)
        present(ac, animated: true)
    }
}
