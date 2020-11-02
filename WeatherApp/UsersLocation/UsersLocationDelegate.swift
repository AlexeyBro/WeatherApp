//
//  UsersLocationDelegate.swift
//  WeatherApp
//
//  Created by Alex on 26.03.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

import Foundation
import CoreLocation


protocol UsersLocationDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailToUpdate error: Error)
        
    func locationManager(_ manager: CLLocationManager, didUpdateUserLocation : [CLLocation])
    
    func locationManager(_ manager: CLLocationManager, didChangeStatus status: CLAuthorizationStatus)
}
