//
//  WeatherModel.swift
//  Weather
//
//  Created by Yusuf Bayindir on 2/2/24.
//

import Foundation
struct WeatherModel {
    var id:Int
    var cityName:String
    var temp:Double
    var tempString:String{
        return String(format: "%.1f", temp)
    }
    var tempMin:Double
    var tempMax:Double
    var description:String
    var iconName:String{
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "snow"
        case 700...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "cloud"
        }
    }
    
}
