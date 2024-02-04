//
//  ViewController.swift
//  Weather
//
//  Created by Yusuf Bayindir on 1/30/24.
//

import UIKit
import CoreLocation
class ViewController: UIViewController {

    
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var conditionImage: UIImageView!
    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var descriptionWeather: UILabel!
    @IBOutlet weak var tempMinandMax: UILabel!
    var weatherControl = WeatherControl()
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        textInput.delegate = self
        weatherControl.delegate = self
        
        
    }

    
}
//MARK: - WeatherControlDelegate

extension ViewController:WeatherControlDelegate{
    func didUpdateWeather(_ weather: WeatherModel){
        DispatchQueue.main.async{      //It is for when weather inf comes program label will change
            self.temperature.text = "\(weather.tempString)°C"
            self.city.text = weather.cityName
            self.conditionImage.image = UIImage(systemName: weather.iconName)
            self.descriptionWeather.text = weather.description.uppercased()
            self.tempMinandMax.text = "\(String(format: "%.1f", weather.tempMin))°C between \(String(format: "%.1f", weather.tempMax))°C"
        }
        
    }
    func didHappenedError(_ error: Error) {
        print(error)
    }
}
//MARK: - UITextFieldDelegate

extension ViewController:UITextFieldDelegate{
    @IBAction func textFieldPressed(_ sender: UITextField) {
        
    }
    
    
    @IBAction func searchButton(_ sender: UIButton) {
        textInput.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textInput.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        weatherControl.findWeatherwithCity(city: textField.text!)
        
        textField.text = ""
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            textField.placeholder = "Search"
            return true
        }else{
            textField.placeholder = "You need to write your city"
            return false
        }
    }
}
//MARK: - CLLocationManagerDelegate
extension ViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherControl.performUrl(urlString: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=f608328cf06a519573b37aca54f75727&units=metric")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    @IBAction func locationButton(_ sender: UIButton) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}
