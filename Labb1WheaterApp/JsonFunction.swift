//
//  Functions.swift
//  Labb1WheaterApp
//
//  Created by Marcus Klaesson on 2020-02-21.
//  Copyright © 2020 Marcus Klaesson. All rights reserved.
//

import UIKit

class JsonFunction: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    func cityListJson() -> [String] {

     let fileName: String = "citylist"

     do {
         if let file = Bundle.main.url(forResource: fileName, withExtension: "json") {
             let data = try Data.init(contentsOf: file)
             let decoder = JSONDecoder()
             let cityList: [String] = try decoder.decode([String].self, from: data)
             return cityList
         }
     } catch {
         print(error)
     }
     return [String]()
     }
    
    


}
