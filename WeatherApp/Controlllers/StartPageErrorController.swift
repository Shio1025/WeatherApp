//
//  StartPageErrorController.swift
//  WeatherApp
//
//  Created by shio birbichadze on 1/24/22.
//  Copyright © 2022 shio birbichadze. All rights reserved.
//

import UIKit



class StartPageErrorController:UIViewController{
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func goToStartPage(){
        let vc = storyboard?.instantiateViewController(withIdentifier : "startPage")
        navigationController?.setViewControllers([vc!], animated: true)
        
        
    }
    
}
