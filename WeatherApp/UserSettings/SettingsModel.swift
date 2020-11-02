//
//  SettingsModel.swift
//  WeatherApp
//
//  Created by Alex on 24.03.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

import Foundation

struct SettingsModel : Codable{
    
    var currentPlace : String?
    var temperatureValue : Int
    var pressureValue : Int
    var timeValue : Int
    var windSpeedValue : Int
    
    var savedLocations : [String]
    
}


