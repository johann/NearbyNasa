//
//  Asteroid.swift
//  NearbyNasa
//
//  Created by Johann Kerr on 8/10/16.
//  Copyright © 2016 Johann Kerr. All rights reserved.
//

import Foundation

import SwiftyJSON

struct AsteroidKey{
   
}

class Asteroid{
    var diameter: Double
    var isHazardous: Bool
    var neoRef: String!
    var velocity: String!
    var missDistanceInKilometers: Double!
    var name:String!
    
    
    init(dict: JSON){
        diameter = dict["estimated_diameter"]["kilometers"]["estimated_diameter_max"].double!
        isHazardous = dict["is_potentially_hazardous_asteroid"].bool!
        neoRef = dict["neo_reference_id"].string
        velocity = dict["close_approach_data"]["relative_velocity"]["kilometers_per_second"].string
        missDistanceInKilometers = dict["close_approach_data"][0]["miss_distance"]["kilometers"].double
        
    
        name = dict["name"].string
    }
}
