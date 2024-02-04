//
//  WeatherModel.swift
//  Weather
//
//  Created by Yusuf Bayindir on 2/2/24.
//

import Foundation
struct WeatherManager:Codable {
    var name:String
    var main:Main
    var weather:[ Weather]
}
struct Main:Codable {   //It is for JSON decode
    var temp:Double
    var temp_min:Double
    var temp_max:Double
}
struct Weather:Codable {
    var id:Int
    var description:String
}
