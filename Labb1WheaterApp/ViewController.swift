//
//  ViewController.swift
//  Labb1WheaterApp
//
//  Created by Marcus Klaesson on 2020-02-03.
//  Copyright © 2020 Marcus Klaesson. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftUI


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var jsonFunction = JsonFunction()
    var cities: [String]?
    

    var cityTemp = [Double]()
    var cityWind = [Double]()
    var cityClouds = [String]()
    var cityCountry = [String]()

    var searching = false

    var cityList = [String]()
    var filteredArray = [String]()
    var myData = String()
    
    var cityListSave = [String]()
    
   
   override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       navigationController?.setNavigationBarHidden(true, animated: animated)
   }
 
    override func viewDidLoad() {
         
        super.viewDidLoad()
        
        cities = jsonFunction.cityListJson()
        
        //loadCitys()
      
   
        viewWillDisappear(true)
        searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
  
    func getCityWeather(cityName: String){
        let weatherAPI = WeatherAPI()
        
        weatherAPI.getWeatherValues(x: cityName) { (result) in
            switch result {
            case .success(let weather): print("Name: " + weather.name)
            DispatchQueue.main.async {
                
         
                self.cityList.append(cityName)
                self.cityTemp.append(weather.main.temp)
                self.cityWind.append(weather.wind!.speed)
                self.cityClouds.append(weather.weather[0].icon!)
                self.cityCountry.append(weather.sys!.country)
                
                print("City: ",self.cityList)
                print("Temp: ",self.cityTemp)
                print("Wind: ",self.cityWind)
                print("Clouds: ",self.cityClouds)
                print("Country: ",self.cityCountry)
                
                self.tableView.reloadData()
                }
                
            case .failure(let error): print("Error: \(error)")
            }
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        let city = searchBar.text
        
        if searchBar.text == nil || searchBar.text == "" {
            searching = false
            view.endEditing(true)
            tableView.reloadData()
        }
        else {
            if let myCities = cities {
                filteredArray = myCities.filter({$0.prefix(searchText.count) == searchText})
                filteredArray += myCities
            }else {
                print("error this is nil")
            }
            filteredArray.append(city!)
            searching = true
            tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if searching {
            return self.filteredArray.count
        }
        else {
            return self.cityList.count
            
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDisplay") as? CustomTableViewCell
        
        func tempUnits(){
            var double = cityTemp[indexPath.row] - 273.15
            double = Double(round(10*double)/10)
            let doubleToString = String(double) + "℃"
            cell?.tempLabel?.text = doubleToString
            cell?.tempLabel?.isHidden = false
        }
        func displayClouds(){
          let key = "@2x.png"
          let baseUrl = "http://openweathermap.org/img/wn/"
            let sendClouds = self.cityClouds[indexPath.row]
          
            let url = URL(string: baseUrl + sendClouds + key)
          let data = try? Data(contentsOf: url!)
         
          if let imageData = data {
              let image = UIImage(data: imageData)
                cell?.weatherIcon?.image = image
                cell?.weatherIcon?.isHidden = false
                
            }
          }
        
        if searching {
            
            cell?.cityLabel?.text = self.filteredArray[indexPath.row]
            cell?.tempLabel?.isHidden = true
            cell?.weatherIcon?.isHidden = true
            
        }
        else {
        
            displayClouds()
            tempUnits()
            cell?.cityLabel?.text = self.cityList[indexPath.row]
            //saveCitys()
            cell?.animateIcon()
        
        }
        
        return cell!
    }
    func saveCitys(){
        
        let defaults = UserDefaults.standard
        defaults.set(self.cityList, forKey: "City")
        //defaults.set(self.cityClouds, forKey: "Clouds")
        print("SAVECITY: ",self.cityList)
        print("SAVECLOUD: ",self.cityClouds)
        
    
    }
    func loadCitys(){
        
        let defaults = UserDefaults.standard
        self.cityList = defaults.stringArray(forKey: "City") ?? [String]()
        //self.cityClouds = defaults.stringArray(forKey: "Clouds") ?? [String]()
        self.tableView.dataSource = self.cityList as? UITableViewDataSource
       // self.tableView.dataSource = self.cityClouds as? UITableViewDataSource
        print("LOADCITY: ",self.cityList)
        //print("LOADCLOUD: ",self.cityClouds)
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (searching) {
            myData = self.filteredArray[indexPath.row]
            getCityWeather(cityName: myData)
            searching = false
            self.searchBar.text?.removeAll()
        
                    
        } else {
            myData = self.cityList[indexPath.row]
            performSegue(withIdentifier: "showCityDetailsSegue", sender: self)
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
     
        var indexPath = IndexPath()
        let detailsVC = segue.destination as? DetailViewController
        
        indexPath = tableView.indexPathForSelectedRow!
       
        let stringArray = cityTemp.map { String($0) }
        detailsVC?.sendTemp = stringArray[indexPath.row]

        let stringArray1 = cityWind.map { String($00) }
        detailsVC?.sendWind = stringArray1[indexPath.row]
     
        let stringArray2 = cityClouds.map { String($0) }
        detailsVC?.sendClouds = stringArray2[indexPath.row]
        
        let stringArray3 = cityList.map { String($0) }
        detailsVC?.sendCity = stringArray3[indexPath.row]
        
        let stringArray4 = cityCountry.map { String($0) }
        detailsVC?.sendCountry = stringArray4[indexPath.row]
     }
 
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cityList.remove(at: indexPath.row)
            cityTemp.remove(at: indexPath.row)
            cityWind.remove(at: indexPath.row)
            cityClouds.remove(at: indexPath.row)
            cityCountry.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        } else if editingStyle == .insert {
            
        }
    }
    
}


   


