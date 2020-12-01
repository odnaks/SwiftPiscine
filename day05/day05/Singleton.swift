//
//  Singleton.swift
//  day05
//
//  Created by Kseniya Lukoshkina on 01.12.2020.
//

import Foundation
import UIKit

class Singleton {
    var places: [Place] = []
    static var shared: Singleton = {
        return Singleton()
    }()
    
    private init() {
        if let path = Bundle.main.url(forResource: "data", withExtension: "json") {
            if let data = try? Data(contentsOf: path) {
                if let dic = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any] {
                    for place in dic {
                        if let placeDic = place as? [String: Any] {
                            if let name = placeDic["name"] as? String,
                               let desc = placeDic["desc"] as? String,
                               let latitude = placeDic["latitude"] as? Double,
                               let longitude = placeDic["longitude"] as? Double,
                               let colorString = placeDic["color"] as? String,
                               let color = UIColor.colorWith(name: colorString){
                                let placeModel = Place(name: name, desc: desc,
                                                       latitude: latitude, longitude: longitude,
                                                       color: color, colorString: colorString)
                                places.append(placeModel)
                                print(placeDic)
                                print("====")
                            }
                        }
                    }
                }
            }
        }
    }

}

extension UIColor {
    static func colorWith(name:String) -> UIColor? {
        switch name {
            case "red":
                return .red
            case "blue":
                return .blue
            case "green":
                return .green
            case "black":
                return .black
            case "orange":
                return .orange
            default:
                return .cyan
        }
    }
}
