//
//  ForecastErrorHandler.swift
//  WeatherApp
//
//  Created by shio birbichadze on 2/12/22.
//  Copyright © 2022 shio birbichadze. All rights reserved.
//

import Foundation
import UIKit

class ForecastErrorController:UIViewController{
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func goToForecastPage(){
        let vc = storyboard?.instantiateViewController(withIdentifier : "ForecastController")
        navigationController?.setViewControllers([vc!], animated: true)
        
        
    }
    
}
