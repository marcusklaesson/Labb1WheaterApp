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
    @IBOutlet weak var button: UIButton!
   
    var cityTemp = [Double]()
    var cityList = [String]()
    
    var cityWind = [Double]()
    var cityClouds = [String]()
    var searching = false
    //var sendClouds: String?
    
  
    var filteredArray = ["Berlin", "Tokyo", "Göteborg"]
    var shouldShowSearchResults = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //searchBar.delegate = self
        //filteredArray = userData as [AnyObject]
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        loadListOfCountries()
        sort()
      
    }
  
    func loadListOfCountries() {
    
    
}
    func sort() {
       // self.filteredArray = self.filteredArray.sorted()
    }
    
    func getCityWeather(cityName: String){
        let weatherAPI = WeatherAPI()
        
        weatherAPI.getWeatherValues(x: cityName) { (result) in
                        switch result {
                        case .success(let weather): print("Name: " + weather.name!)
                          DispatchQueue.main.async {
                        
                            
                            self.cityList.append(cityName)
                            self.cityTemp.append(weather.main.temp)
                            self.cityWind.append(weather.wind.speed)
                            self.cityClouds.append(weather.weather[0].icon)
                            
                            
                            
                            print("City: ",self.cityList)
                            print("Temp: ",self.cityTemp)
                            print("Wind: ",self.cityWind)
                            print("Clouds: ",self.cityClouds)
                            
                             self.tableView.reloadData()
                          }

                          case .failure(let error): print("Error: \(error)")
                        }

                    }
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        
        
        
        if searchBar.text == nil || searchBar.text == "" {
                
               searching = false
               view.endEditing(true)
               tableView.reloadData()
           }
           else {
           
            //filteredArray = cityList.filter({$0.prefix(searchText.count) == searchText})
           
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // convert double to string and kelvin to celsius
        /*func tempUnits(){
                        
                       var double = cityTemp[indexPath.row] - 273.15
                         double = Double(round(10*double)/10)
                         let doubleToString = String(double) + "℃"
                         cell.detailTextLabel?.text = doubleToString
                        }
        
       
        tempUnits()*/
        
       if searching {
           
        cell.textLabel?.text = self.filteredArray[indexPath.row]
       }
       else {
        cell.textLabel?.text = self.cityList[indexPath.row]
       }
        
      
        
            
            return cell

       

        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("funkar??!?!?")
        filteredArray = [cityList[indexPath.row]]
        
        
        
        
        /*let city = cityList[indexPath.row]
        getCityWeather(cityName: city)*/
    
        self.performSegue(withIdentifier: "InputVCToDisplayVC", sender: self)
         
        
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        
        
        if segue.identifier == "InputVCToDisplayVC" {
        var indexPath = IndexPath()
        let detailsVC = segue.destination as! DetailViewController
        indexPath = tableView.indexPathForSelectedRow!
        
        let stringArray = cityTemp.map { String($0) }
        detailsVC.sendTemp = stringArray[indexPath.row]
        
        let stringArray1 = cityWind.map { String($00) }
        detailsVC.sendWind = stringArray1[indexPath.row]
        
        let stringArray2 = cityClouds.map { String($0) }
        detailsVC.sendClouds = stringArray2[indexPath.row]
            }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cityList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
           
        }
    }

}



