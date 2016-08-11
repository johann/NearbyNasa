//
//  ViewController.swift
//  NearbyNasa
//
//  Created by Johann Kerr on 8/9/16.
//  Copyright © 2016 Johann Kerr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let store = AsteroidDatastore.sharedDataStore

    override func viewDidLoad() {
        super.viewDidLoad()
        store.getNearbyAsteroids {
            for asteroid in self.store.nearByAsteroids{
                print(String(asteroid.missDistanceInKilometers))
            }
        }
    }
    
    
}

