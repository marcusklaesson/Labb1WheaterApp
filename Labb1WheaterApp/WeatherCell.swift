//
//  WeatherCell.swift
//  Labb1WheaterApp
//
//  Created by Marcus Klaesson on 2020-02-04.
//  Copyright © 2020 Marcus Klaesson. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    var weatherImageView = UIImageView()
    var cityTitleLabel = UILabel()
    var tempDetailLabel = UILabel()
    

    func configureImageView(){
        weatherImageView.layer.cornerRadius = 10
        weatherImageView.clipsToBounds = true
        
    }
    func configureLabel(){
        cityTitleLabel.numberOfLines = 0
        cityTitleLabel.adjustsFontSizeToFitWidth = true
        tempDetailLabel.numberOfLines = 0
        tempDetailLabel.adjustsFontSizeToFitWidth = true
    }
    func setImageConstraints(){
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        weatherImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        weatherImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        weatherImageView.widthAnchor.constraint(equalTo: weatherImageView.heightAnchor, multiplier: 16/9).isActive = true
        
    }
    func setTitleConstraints(){
        cityTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cityTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cityTitleLabel.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 20).isActive = true
        cityTitleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        cityTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    func setTempConstraints(){
        cityTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cityTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cityTitleLabel.leadingAnchor.constraint(equalTo: cityTitleLabel.trailingAnchor, constant: 50).isActive = true
        cityTitleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        cityTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
    }


}
