//
//  CustomTableViewCell.swift
//  Labb1WheaterApp
//
//  Created by Marcus Klaesson on 2020-02-17.
//  Copyright © 2020 Marcus Klaesson. All rights reserved.
//

import UIKit


class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    func animateIcon(){
        UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            
            self.weatherIcon?.transform = CGAffineTransform(translationX:0, y: -10)
            self.cityLabel?.transform = CGAffineTransform(translationX:0, y: -10)
            self.tempLabel?.transform = CGAffineTransform(translationX:0, y: -10)
            
        }, completion: nil)
    }
}
