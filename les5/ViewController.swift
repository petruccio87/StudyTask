//
//  ViewController.swift
//  les5
//
//  Created by Petr Shibalov on 05.07.17.
//  Copyright © 2017 OSX. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let apikey = "AIzaSyCzZGMY1lCgjzX1aVAEGXluHrKS19YDr4w"
        let latlng = "55.761704,37.620350"
        let radius = "150"
        let rankby = "distance"
        let placeType = "bar"
        let language = "ru"
        
        let urlByRadius = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location="+latlng+"&radius="+radius+"&opennow=true&type="+placeType+"&language="+language+"&key=" + apikey
        let urlByDistance = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location="+latlng+"&rankby="+rankby+"&opennow=true&type="+placeType+"&language="+language+"&key=" + apikey
        
        Alamofire.request(urlByDistance, method: .get).validate().responseJSON { response in
            switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    if json["status"].stringValue == "OK" {
                        for (key,place):(String, JSON) in json["results"] {
                            print(key, " ", place["name"].stringValue)
                            print("     Rating: ", place["rating"].stringValue)
                            print("     Price Level: ", place["price_level"].stringValue)   // не везде есть
                            print("     LatLng: ", place["geometry"]["location"]["lat"].stringValue, ",", place["geometry"]["location"]["lng"].stringValue)
                            print("     Адрес: ", place["vicinity"].stringValue)
                        }
                    }
                    //print("Json ResponseResult: \(json)")
                case .failure(let error):
                    print(error)
            }
        /*    print(response.request)
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            } */
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

