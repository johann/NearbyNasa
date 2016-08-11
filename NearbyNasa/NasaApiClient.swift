//
//  NasaApiClient.swift
//  NearbyNasa
//
//  Created by Johann Kerr on 8/9/16.
//  Copyright © 2016 Johann Kerr. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NasaApiClient{

    class func getAsteroid(value:String, completion:(Asteroid)->()){
        var url = "\(Constants.apiItemURL)\(value)?api_key=\(Constants.apiKey)"
        
        Alamofire.request(.GET, url).responseJSON { (response) in
            guard let jsonData = response.data else{ assertionFailure("no json");return }
            let json = JSON(data:jsonData)
            let newAsteroid = Asteroid(dict: json)
            completion(newAsteroid)
           
        }
    }
    class func getTodaysAsteroids(completion:([Asteroid])->()){
        var date = NSDate()
        let dateFormatter = NSDateFormatter()
        var asteroidDataArray = [Asteroid]()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        var todayString = dateFormatter.stringFromDate(date)
        var oneDayfromNow: NSDate {
            return NSCalendar.currentCalendar().dateByAddingUnit(.Day,
                                                                 value: 1, toDate: NSDate(), options: [])!
        }
        let tomorrowString = dateFormatter.stringFromDate(oneDayfromNow)
        let url = "\(Constants.apiFeedURL)?start_date=\(todayString)&end_date=\(tomorrowString)&api_key=\(Constants.apiKey)"
        
        Alamofire.request(.GET, url).responseJSON { (response) in
            guard let jsonData = response.data else{ assertionFailure("no json");return }
            let json = JSON(data:jsonData)
            
            guard let asteroidArray = json["near_earth_objects"][todayString].array else{assertionFailure("Failed to set asteroid");return}
            
            for asteroid in asteroidArray{
                let newAsteroid = Asteroid(dict: asteroid)
                asteroidDataArray.append(newAsteroid)
            }
            
            completion(asteroidDataArray)
        }
        
    }
    class func getRandomAsteroids(completion:([Asteroid])->()){
        var asteroidDataArray = [Asteroid]()
        let url = "\(Constants.apiRandomURL)"
        Alamofire.request(.GET, url).responseJSON { (response) in
            guard let jsonData = response.data else{ assertionFailure("no json");return }
            let json = JSON(data:jsonData)
            guard let asteroidArray = json["near_earth_objects"].array else{assertionFailure("Failed to set asteroid");return}
            for asteroid in asteroidArray{
                let newAsteroid = Asteroid(dict: asteroid)
                asteroidDataArray.append(newAsteroid)
            }
            completion(asteroidDataArray)
        }
    }
}
