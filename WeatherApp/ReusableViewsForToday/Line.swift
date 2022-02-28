//
//  Line.swift
//  WeatherApp
//
//  Created by shio birbichadze on 2/11/22.
//  Copyright © 2022 shio birbichadze. All rights reserved.
//

import Foundation
import UIKit

class Line:UIView{
    
    @IBOutlet var contentView:UIView!
    @IBOutlet var line:UIView!
    
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
        let bundle=Bundle(for:Line.self)
        bundle.loadNibNamed("LineView", owner: self, options: nil)
        
        contentView.frame=bounds
        contentView.autoresizingMask=[.flexibleWidth,.flexibleHeight]
        
        addSubview(contentView)
        
        
        
        
    }
    
    func setUp(){
        
        
    }
    
    
}
