//
//  DetailViewController.swift
//  Labb1WheaterApp
//
//  Created by Marcus Klaesson on 2020-02-11.
//  Copyright © 2020 Marcus Klaesson. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var tempLabel: UILabel?
    @IBOutlet weak var windLabel: UILabel?
    @IBOutlet weak var cloudImage: UIImageView?
    @IBOutlet weak var cityLabel: UILabel?
    @IBOutlet weak var cityCountry: UILabel?
    @IBOutlet weak var clothesWeather: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    
    
    var sendCity: String?
    var sendTemp: String?
    var sendWind: String?
    var sendClouds: String?
    var sendCountry: String?
    
    var temp: String?
    
    var animator: UIDynamicAnimator!
    var collision : UICollisionBehavior!
    var bounce: UIDynamicItemBehavior!
    
    var customTableViewCell = CustomTableViewCell()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewWillDisappear(false)
        
        animator = UIDynamicAnimator(referenceView: view)
        
        clothesForWeather()
        displayCity()
        displayClouds()
        displayWind()
        displayTemp()
        displayCountry()
    }
    func displayCountry(){
        cityCountry?.text = "(" + sendCountry! + ")"
    }
    func displayCity(){
        cityLabel?.text = sendCity
    }
    func displayClouds(){
        let key = "@2x.png"
        let baseUrl = "http://openweathermap.org/img/wn/"
        
        let url = URL(string: baseUrl + sendClouds! + key)
        let data = try? Data(contentsOf: url!)
        
        if let imageData = data {
            let image = UIImage(data: imageData)
            cloudImage?.image = image
        }
        animations()
    }
    func displayWind(){
        var DoubleValue = (sendWind! as NSString).doubleValue
        DoubleValue = Double(round(10*DoubleValue)/10)
        sendWind = "\(DoubleValue)"
        
        windLabel?.text = sendWind! + "M/S"
    }
    func displayTemp(){
        var DoubleValue = (sendTemp! as NSString).doubleValue - 273.15
        DoubleValue = Double(round(10*DoubleValue)/10)
        sendTemp = "\(DoubleValue)"
        
        tempLabel?.text = sendTemp! + "℃"
    }
    func clothesForWeather(){
        dynamicBehavior()
        
        var currentTemp = (sendTemp! as NSString).doubleValue - 273.15
        currentTemp = Double(round(10*currentTemp)/10)
        temp = "\(currentTemp)"
        
        let itemHotAsHell = "naked?!"
        let itemWarm = "t-shirt and longpants."
        let itemMedium = "a thin jacket and longpants."
        let itemUnderMedium = "jacket and longpants."
        let itemCold = "a thick jacket and longpants."
        let itemColdAsHell = "the thickest jacket and longpants you have!!!"
        
        if currentTemp > 25 {
            clothesWeather.text = "Todays weather with the temperture of " + temp! + "℃ allows you to be " + itemHotAsHell
        } else if currentTemp > 20 {
            clothesWeather.text = "Todays weather with the temperture of " + temp! + "℃ allows you to wear " + itemWarm
        } else if currentTemp > 15 {
            clothesWeather.text = "Todays weather with the temperture of " + temp! + "℃ allows you to wear " + itemMedium
        } else if currentTemp > 10 {
            clothesWeather.text = "Todays weather with the temperture of " + temp! + "℃ allows you to wear " + itemUnderMedium
        } else if currentTemp > 0 {
            clothesWeather.text = "Todays weather with the temperture of " + temp! + "℃ allows you to wear " + itemCold
        } else if currentTemp < 0 {
            clothesWeather.text = "Todays weather with the temperture of " + temp! + "℃ allows you to wear " + itemColdAsHell
        }
        viewController.reloadInputViews()
    }
    func dynamicBehavior(){
        var gravity: UIDynamicBehavior
        gravity = UIGravityBehavior(items: [clothesWeather])
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: [clothesWeather])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        let bounce: UIDynamicItemBehavior
        bounce = UIDynamicItemBehavior(items: [clothesWeather])
        bounce.elasticity = 0.7
        animator.addBehavior(bounce)
    }
    func animations(){
        UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            
            self.cloudImage?.transform = CGAffineTransform(translationX:0, y: -10)
            
        }, completion: nil)
    }
}

