//
//  Layout.swift
//  AFTut
//
//  Created by Nithin M Das on 12/10/17.
//  Copyright © 2017 Voltella. All rights reserved.
//

import UIKit
import FLXView

open class Layout: FLXView {
    
    var margin_top : Int = 0
    var margin_bottom : Int = 0
    var margin_left : Int = 0
    var margin_right : Int = 0
    
    /*public convenience init(margin : Int, marginLeft: Int , marginRight : Int ,marginTop: Int , marginBottom : Int ,padding: Int , paddingLeft : Int , paddingRight : Int , paddingTop : Int , paddingBottom : Int , weight : String ,  direction : String , bgColor : String) {
        self.init()
 
        
        
            
            margin_top = margin ?? marginTop
            margin_bottom = margin ?? marginBottom
            margin_left = margin ?? marginLeft
            margin_right = margin ?? marginRight
            
        
       flx_margins = FLXMargins(top: CGFloat(margin_top), left: CGFloat(margin_left), bottom: CGFloat(margin_bottom), right: CGFloat(margin_right))
        
    }
    */
    
    public convenience init( directions : String , bgColor : String) {
        self.init()
        
        if (directions == "column") {
            direction = .column
        }
        else{
            direction = .row
        }

        backgroundColor = UIColor(hex:bgColor)
        
    }
    
    
    
    
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
