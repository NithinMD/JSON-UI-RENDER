//
//  Sepearator.swift
//  AFTut
//
//  Created by Nithin M Das on 11/10/17.
//  Copyright © 2017 Voltella. All rights reserved.
//

import UIKit

open class Separator: UIView {
    public convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        
        backgroundColor = UIColor(white: 0.92, alpha: 1)
    }
    
}


