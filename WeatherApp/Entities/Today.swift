//
//  Today.swift
//  WeatherApp
//
//  Created by shio birbichadze on 2/4/22.
//  Copyright © 2022 shio birbichadze. All rights reserved.
//

import Foundation



struct weather:Codable{
    let weather:[w1]
    let main:m1
    let wind:forWind
    let clouds:cloudy
    let name:String
    let sys:sys
}


struct w1:Codable{
    let main:String
    let description:String
    let icon:String
    
    
}

struct m1:Codable{
    let temp:Float
    let pressure:Float
    let humidity:Float
}

struct forWind:Codable{
    
    let speed:Float
    let deg:Float
    
}

struct cloudy:Codable{
    
    let all:Float
}

struct sys:Codable{
    
    let country:String
}
