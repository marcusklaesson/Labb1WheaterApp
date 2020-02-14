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
    
    
    func getWeatherValues(x : String, completion: @escaping( Result<Weather, Error>) -> Void) {
        // url
        let urlString = baseURL + x + key
        print(urlString)
        guard let url: URL = URL(string: urlString) else { return }
        // Request
        print("Creating request..")
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let unwrappedError = error {
                print("Nått gick fel. Error: \(unwrappedError)")
                completion(.failure(unwrappedError))
                return
            }
            if let unwrappedData = data {
                 //print("We got data! \(String(data: unwrappedData, encoding: String.Encoding.utf8) ?? "No data")")
                do {
                    let decoder = JSONDecoder()
                    let weather: Weather = try decoder.decode(Weather.self, from: unwrappedData)
                    
                    
        
                    print("Weather id: \(weather.id)")
                    print("Weather name: \(String(describing: weather.name))")
                    
                    completion(.success(weather))
                } catch {
                    print("Couldnt parse JSON..")
                }
                
            }
        }
        // Starta task
        task.resume()
        print("Task started")
    
    }
    
}
