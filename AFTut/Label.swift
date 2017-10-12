//
//  Label.swift
//  AFTut
//
//  Created by Nithin M Das on 11/10/17.
//  Copyright © 2017 Voltella. All rights reserved.
//

import UIKit

open class Label: UILabel {
    
    public convenience init(text string: String, align: NSTextAlignment = .left, appearance: String , dim : String ) {
        self.init()
        
        if appearance == "headline" {
            font = UIFont(name: "Avenir Next", size: 24)
        }
        else if appearance == "title"{
            font = UIFont(name: "Avenir Next Medium", size: 20)
        }
        else if appearance == "subhead"{
            font = UIFont(name: "Avenir Next", size: 16)
        }
        else if appearance == "Body 2"{
            font = UIFont(name: "Avenir Next Medium", size: 14)
        }
        else if appearance == "Body 1"{
            font = UIFont(name: "Avenir Next", size: 14)
        }
        else if appearance == "Caption"{
            font = UIFont(name: "Avenir Next", size: 12)
        }
        else{
            font = UIFont(name: "Avenir Next", size: 12)
        }
        
        numberOfLines = 0
        text = string
        lineBreakMode = NSLineBreakMode.byCharWrapping
        
    }
    
    
}

