//
//  TodayErrorHandler.swift
//  WeatherApp
//
//  Created by shio birbichadze on 2/12/22.
//  Copyright © 2022 shio birbichadze. All rights reserved.
//

import Foundation
import UIKit

class TodayErrorController:UIViewController{
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func goToTodayPage(){
        let vc = storyboard?.instantiateViewController(withIdentifier : "TodayController")
        navigationController?.setViewControllers([vc!], animated: true)
        
        
    }
    
}
