//
//  WeatherControl.swift
//  Weather
//
//  Created by Yusuf Bayindir on 2/1/24.
//urlString =
protocol WeatherControlDelegate {
    func didUpdateWeather(_ weather: WeatherModel)
    func didHappenedError(_ error: Error)
}
import Foundation
struct WeatherControl {
    var delegate:WeatherControlDelegate?
    func findWeatherwithCity(city:String) {
        performUrl(urlString: "https://api.openweathermap.org/data/2.5/weather?appid=f608328cf06a519573b37aca54f75727&q=\(city)&units=metric")
    }
    func performUrl(urlString:String) {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler:{ data, urlR, err in
                if err != nil{
                    self.delegate?.didHappenedError(err!)
                    return
                }
                let weather = self.parseJSON(data: data)
                self.delegate!.didUpdateWeather(weather)
                
            })
            task.resume()
            
        }
        
    }
    func parseJSON(data:Data?) -> WeatherModel{
        let decoder = JSONDecoder()
        do{
            let decodeJSON = try decoder.decode(WeatherManager.self, from: data!)
            
            return WeatherModel(id: decodeJSON.weather[0].id, cityName: decodeJSON.name, temp: decodeJSON.main.temp, tempMin: decodeJSON.main.temp_min, tempMax: decodeJSON.main.temp_max, description: decodeJSON.weather[0].description)
        }catch{
            delegate?.didHappenedError(error)
            return WeatherModel(id: 0, cityName: "", temp: 0.0, tempMin: 0.0, tempMax: 0.0, description: "")
        }
    }
}
