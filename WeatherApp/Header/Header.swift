//
//  Header.swift
//  WeatherApp
//
//  Created by shio birbichadze on 2/5/22.
//  Copyright © 2022 shio birbichadze. All rights reserved.
//

import UIKit

class Header: UITableViewHeaderFooterView {

    let title = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureContents()
    }
    
    
    func configureContents() {
       
        title.translatesAutoresizingMaskIntoConstraints = false
        
        
        contentView.addSubview(title)
        
       
        NSLayoutConstraint.activate([
            
            
            
            title.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor,
                                           constant: 5),
            title.trailingAnchor.constraint(equalTo:
                contentView.layoutMarginsGuide.trailingAnchor),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.black.cgColor
    }

}
