//
//  CurrentService.swift
//  WeatherApp
//
//  Created by shio birbichadze on 2/4/22.
//  Copyright © 2022 shio birbichadze. All rights reserved.
//

import Foundation
import CoreLocation

class CurrentService{
    
    private var components = URLComponents()
    private let apiKey="2234c53075103df7b22cef56ffbfdac5"
    private let units="metric"
    
    init(){
        components.scheme="https"
        components.host="api.openweathermap.org"
        components.path="/data/2.5/weather"
        
    }
    
    
    
    func loadWeather( lat:CLLocationDegrees,lon:CLLocationDegrees,completion: @escaping (Result< weather >)->()){
        let parameters=[
            
            "lat" : lat.description,
            "lon" : lon.description,
            "appid" :apiKey.description,
            "units" : units.description
        ]
        
        components.queryItems=parameters.map{ key,value in
            return URLQueryItem(name:key,value:value)
            
        }
        
        if let url=components.url{
            let request=URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request,completionHandler:{data,response, error in
                if let error=error{
                    completion(Result.error(error))
                    return
                }
                
                if let data = data{
                    let decoder=JSONDecoder()
                    do{
                        let result=try decoder.decode(weather.self,from: data)
                        
                        completion(Result.value(result))
                        //print(result)
                    }catch{
                        completion(Result.error(error))
                    }
                    
                }else{
                    completion(Result.error(errors.noData))
                }
                
                
            })
            task.resume()
        }else{
            
            completion(Result.error(errors.invalidParameters))
            
        }
        
    }
    
}

