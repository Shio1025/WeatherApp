//
//  OneFeature.swift
//  WeatherApp
//
//  Created by shio birbichadze on 2/10/22.
//  Copyright © 2022 shio birbichadze. All rights reserved.
//

import Foundation
import UIKit

class OneFeature:UIView{
    
   
    
    @IBOutlet var contentView:UIView!
    @IBOutlet var image:UIImageView!
    @IBOutlet var info: UILabel!
    
   
    
   
    
    
    
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
        let bundle=Bundle(for:OneFeature.self)
        bundle.loadNibNamed("FeatureView", owner: self, options: nil)
        
        contentView.frame=bounds
        contentView.autoresizingMask=[.flexibleWidth,.flexibleHeight]
        
        addSubview(contentView)
        
        
        
        
    }
    
    func setUp(){
        
    }
}
