//
//  Features.swift
//  WeatherApp
//
//  Created by shio birbichadze on 2/10/22.
//  Copyright © 2022 shio birbichadze. All rights reserved.
//

import Foundation
import UIKit

class Features:UIView{
    
    
    
    @IBOutlet var contentView:UIView!
    @IBOutlet var clouds:OneFeature!
    @IBOutlet var humidity:OneFeature!
    @IBOutlet var pressure:OneFeature!
    @IBOutlet var windSpeed:OneFeature!
    @IBOutlet var windDirection:OneFeature!
    
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        setUp()
    }
    
    func commonInit(){
        let bundle=Bundle(for:Features.self)
        bundle.loadNibNamed("BottomFeaturesView", owner: self, options: nil)
        
        contentView.frame=bounds
        contentView.autoresizingMask=[.flexibleWidth,.flexibleHeight]
        
        addSubview(contentView)
        
        
        
        
    }
    
    func setUp(){
        clouds.image.image=UIImage(named: "raining")
        humidity.image.image=UIImage(named: "drop")
        pressure.image.image=UIImage(named: "celsius")
        windSpeed.image.image=UIImage(named: "wind")
        windDirection.image.image=UIImage(named: "compass")
        
    }
}
