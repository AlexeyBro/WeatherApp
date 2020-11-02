//
//  Section.swift
//  WeatherApp
//
//  Created by Alex on 25.03.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

import UIKit


class Section {

    let name : String
    var items : [String]
        
    init(name : String, items : [String]) {
        self.name = name
        self.items = items
    }
}
