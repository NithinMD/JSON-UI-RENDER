//
//  Label.swift
//  AFTut
//
//  Created by Nithin M Das on 11/10/17.
//  Copyright © 2017 Voltella. All rights reserved.
//

import UIKit

open class Label: UILabel {
    
    public convenience init(text string: String, align: NSTextAlignment = .left, fontSize: CGFloat = 20) {
        self.init()
        
        font = UIFont(name: "Avenir Next", size: fontSize)
        numberOfLines = 0
        text = string
        
    }
    
    
}

