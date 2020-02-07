//
//  ViewController.swift
//  Labb1WheaterApp
//
//  Created by Marcus Klaesson on 2020-02-03.
//  Copyright © 2020 Marcus Klaesson. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button: UIButton!
    
    
    
    var addCity = [String]()
    var searching = false
    var cityName = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        tableView.register(WeatherCell.self, forCellReuseIdentifier: "WeatherCell")
       
    }
    
    @IBAction func button(_ sender: Any) {
        
       
        
        let alertController = UIAlertController(title: "City", message: "Type in cityname", preferredStyle: .alert)
        
            alertController.addTextField { textField in
            textField.placeholder = "Enter city"
            
        }
                
        let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            print("You've pressed ok");
            let firstTextField = alertController.textFields![0] as UITextField
            
            self.addCity.append(firstTextField.text!)
            print(self.addCity)
            self.tableView.reloadData()
            
            
        }

        let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
            print("You've pressed cancel");
        }
        
    

        alertController.addAction(action1)
        alertController.addAction(action2)
      
        self.present(alertController, animated: true, completion: nil)
        
        
        
    }
    
    
   /* func getCityWeather(){
        let weatherAPI = WeatherAPI()

            weatherAPI.getWeatherValues { (result) in
                        switch result {
                        case .success(let weather): print("Value: " + weather.name)
                          DispatchQueue.main.async {
                           
                          }

                          case .failure(let error): print("Error: \(error)")
                        }

                    }
        
    }*/
    
   /* func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    
        
            if searchBar.text == nil || searchBar.text == "" {
               searching = false
               print("search not active")
               view.endEditing(true)
               tableView.reloadData()

           } else {

               searching = true
               print("search is active")
               
                
                addCity = searchCity.filter({$0.prefix(searchText.count) == searchText})
               
               tableView.reloadData()
             
           }
                   // addCity.append(searchBar.text!)
                       //            print(addCity)
                   
    
        
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        
        
        /*if searching {
            //print("numberofrowinsectionCountry",(searchCountry))
            return addCity.count
            
        }else{
            //print("numberofrowinsectionArraylist",(arrayList))
            return searchCity.count
            
        }*/
        return self.addCity.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as! WeatherCell
        
        cell.textLabel?.text = self.addCity[indexPath.row]
        
        //let weatherAPI = addCity[indexPath.row]
        
        //cell.textLabel?.text = weatherAPI
    
        /*if searching {
            cell.textLabel?.text = searchCountry[indexPath.row]
            print("tableViewCountry",(searchCountry))
            cell.imageView?.image = UIImage(named: "sunny")
            cell.detailTextLabel?.text = "10°C"
        }else{
            cell.textLabel?.text = arrayList[indexPath.row]
            print("tableViewArrayList",(arrayList))
            cell.imageView?.image = UIImage(named: "sunny")
            cell.detailTextLabel?.text = "20°C"
        }*/

        return cell
    }
    
    

}


