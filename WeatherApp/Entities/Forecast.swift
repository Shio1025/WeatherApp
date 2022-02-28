//
//  Forecast.swift
//  WeatherApp
//
//  Created by shio birbichadze on 2/4/22.
//  Copyright © 2022 shio birbichadze. All rights reserved.
//

import Foundation




struct forecast5:Codable{
    let list:[forecast]
}

struct forecast:Codable{
    let main:forTemp
    let weather:[forIconAndDescription]
    let dt_txt:String
    
    
}


struct forTemp:Codable{
    let temp:Float
    
}

struct forIconAndDescription:Codable{
    let icon:String
    let description:String
    
}
