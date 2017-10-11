//
//  SubHead.swift
//  AFTut
//
//  Created by Nithin M Das on 11/10/17.
//  Copyright © 2017 Voltella. All rights reserved.
//

import UIKit

open class SubHead: UILabel {
    
    public convenience init(text string: String, align: NSTextAlignment = .left) {
        self.init()
        
        font = UIFont(name: "Avenir Next", size: 16)
        numberOfLines = 2
        text = string
        
    }
    
    
}
