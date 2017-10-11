//
//  Button.swift
//  AFTut
//
//  Created by Nithin M Das on 11/10/17.
//  Copyright © 2017 Voltella. All rights reserved.
//

import UIKit


open class Button: UIButton {
    public convenience init(label: String) {
        self.init()
        
        setTitle(label, for: UIControlState())
        layer.cornerRadius = 5
    }
}
