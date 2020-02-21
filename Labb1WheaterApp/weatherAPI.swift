//
//  weatherAPI.swift
//  Labb1WheaterApp
//
//  Created by Marcus Klaesson on 2020-02-04.
//  Copyright © 2020 Marcus Klaesson. All rights reserved.
//

import Foundation

var viewController = ViewController()

struct WeatherAPI {
    
    let baseURL: String = "https://api.openweathermap.org/data/2.5/weather?q="
    let key: String = "&APPID=2a5609d7b130e0bbf6cd10ddb7e3a916"
    
    func getWeatherValues(city : String, completion: @escaping( Result<Weather, Error>) -> Void) {
        
        let UrlString = baseURL + city + key
        let urlString = UrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let url: URL = URL(string: urlString!) else { return }
        print("Creating request..")
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let data = data {
                //print("We got data! \(String(data: data, encoding: String.Encoding.utf8) ?? "No data")")
                
                do {
                    let decoder = JSONDecoder()
                    let weather: Weather = try decoder.decode(Weather.self, from: data)
                    
                    print("Weather name: \(String(describing: weather.name))")
                    
                    completion(.success(weather))
                } catch {
                    print("Error serializing Json: ", error)
                }
            }
        }
        task.resume()
        print("Task started")
    }
}
