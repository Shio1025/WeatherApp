//
//  TabBarController.swift
//  WeatherApp
//
//  Created by shio birbichadze on 1/23/22.
//  Copyright © 2022 shio birbichadze. All rights reserved.
//



import UIKit



class TabBarController:UITabBarController{
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //createTabBarItems()
        
        
        
        
    }
    
    func createTabBarItems(){
        
        for i in [0,1]{
            switch i{
                case 0:
                
                    tabBar.items?[0].title = "Today"
                    let firstTab = self.tabBar.items![i] as UITabBarItem
                    firstTab.image = UIImage(named: "sun1.png")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                    firstTab.selectedImage = UIImage(named: "sun2.png")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                    firstTab.imageInsets = UIEdgeInsets(top: -1, left: 0, bottom: 1, right: 0)
                    firstTab.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
                
                
                case 1:
                
                    tabBar.items?[1].title = "Forecast"
                    let secondTab = self.tabBar.items![i] as UITabBarItem
                    
                    secondTab.image = UIImage(named: "history1.png")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                    secondTab.selectedImage = UIImage(named: "history2.png")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                    secondTab.imageInsets = UIEdgeInsets(top: -1, left: 0, bottom: 1, right: 0)
                    secondTab.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
                
                default:
                    break
            }
            
            
        }
    }
    
}
