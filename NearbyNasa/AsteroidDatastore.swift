//
//  AsteroidDatastore.swift
//  NearbyNasa
//
//  Created by Johann Kerr on 8/10/16.
//  Copyright © 2016 Johann Kerr. All rights reserved.
//

import Foundation


class AsteroidDatastore{

    
    static let sharedDataStore = AsteroidDatastore()
    var nearByAsteroids = [Asteroid]()
    
    
    func getNearbyAsteroids(completion:()->()){
        NasaApiClient.getTodaysAsteroids { (asteroids) in
            self.nearByAsteroids = asteroids
            completion()

        }
    }
    
    
    
}
