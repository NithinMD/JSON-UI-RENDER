//
//  ViewController.swift
//  AFTut
//
//  Created by Nithin M Das on 08/10/17.
//  Copyright © 2017 Voltella. All rights reserved.
//

import UIKit
import FLXView
import SwiftyJSON



class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    let flexView : FLXView = FLXView()
    var layout : FLXView = FLXView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //READ THE JSON FILE
        readJson()
        
        scrollView.addSubview(flexView)
    }
    
    
    override func viewDidLayoutSubviews() {
        flexView.frame.size = flexView.sizeThatFits(CGSize(width: scrollView.bounds.width, height: CGFloat.greatestFiniteMagnitude))
        
        scrollView.contentSize = flexView.bounds.size
    }
    

    
    private func readJson() {
        do {
            if let file = Bundle.main.url(forResource: "sample", withExtension: "json") {
                let data = try Data(contentsOf: file)
                
                
                let json = JSON(data: data)
                
                
                if json.dictionary != nil {
                    // json is a dictionary
                
                    traverseTree(node: json)   //TRAVERSE JSON
                    
                    
                } else if json.array != nil {
                    // json is an array
                    
                    traverseTree(node: json)   //TRAVERSE JSON
                
                    
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    // TRAVERSE THE JSON TREE
    
    func traverseTree(node:JSON) {
       
        
        
        
        for (index,each) in node {
            
            if node.dictionary != nil {
                
                traverseTree(node: each)
                
            }
            if let object = node.array {
                print(index)
                print(object[Int(index)!]["item"])
                
                if (object[0]["item"] == "af-layout") {
                    layout = setupLayout(subjson: object,index: index)
                    
                    
                }
                else if(object[0]["item"] == "af-label"){
                    let subheadView = setupProperties(subjson: object,index: index)
                    
                    layout.addSubview(subheadView)
                }
                
                
                
                
                traverseTree(node: each)
                
                flexView.addSubview(layout)
            }
            
           
            
        }
        
        
        
        
    }
    
    
    
    //SET  MARGINS
    func _Margin(margin:JSON) -> (FLXMargins)  {
        
        var margin_top : Int = 0
        var margin_bottom : Int = 0
        var margin_left : Int = 0
        var margin_right : Int = 0

        
        if (margin["margin"].null == nil) {
            
            
            margin_top = margin["margin"].intValue
            margin_bottom = margin["margin"].intValue
            margin_left = margin["margin"].intValue
            margin_right = margin["margin"].intValue
            
            
        }
        else{
            margin_top = margin["margin-top"].intValue
            margin_bottom = margin["margin-bottom"].intValue
            margin_left = margin["margin-left"].intValue
            margin_right = margin["margin-right"].intValue
            
            
        }
        return FLXMargins(top: CGFloat(margin_top), left: CGFloat(margin_left), bottom: CGFloat(margin_bottom), right: CGFloat(margin_right))
        
    }
    
    
    
    //SET PADDING
    func label_Padding(padding:JSON) -> (FLXPadding)  {
        
        var padding_top : CGFloat = 0.0
        var padding_bottom : CGFloat = 0.0
        var padding_left : CGFloat = 0.0
        var padding_right : CGFloat = 0.0
        
        if (padding["padding"].null == nil) {
            
        
            
            padding_top = CGFloat(padding["padding"].intValue)
            padding_bottom = CGFloat(padding["padding"].intValue)
            padding_left = CGFloat(padding["padding"].intValue)
            padding_right = CGFloat(padding["padding"].intValue)
            
            
            
            
        }
        else{
            padding_top = CGFloat(padding["padding-top"].intValue)
            padding_bottom = CGFloat(padding["padding-bottom"].intValue)
            padding_left = CGFloat(padding["padding-left"].intValue)
            padding_right = CGFloat(padding["padding-right"].intValue)
            
            
            
        }
        
        return FLXPaddingMake(padding_top, padding_right, padding_bottom, padding_left)
        
    }
    
    
    
    
    
    
    
    
    //Setup Properties of subHeading and layout
    
    func setupLayout(subjson:[JSON] , index:String) -> FLXView {
    
        let bgColor = subjson[Int(index)!]["props"]["bg-color"].stringValue
        
        var bgColorValue = String()
        if (!bgColor.isEmpty) {
            
            bgColorValue = bgColor.replacingOccurrences(of: "#", with: "")
            
        }
        else{
            
            bgColorValue = "FFFFFF"
        
        }

        let layoutLevel = Layout(directions : subjson[Int(index)!]["props"]["direction"].stringValue  ,
                                bgColor : bgColorValue )
        
        
            
            let margins = _Margin(margin: subjson[Int(index)!]["props"])
            
            
            layoutLevel.flx_margins = margins
            
        
            layoutLevel.childAlignment = .start
        
            
            let padding = label_Padding(padding: subjson[Int(index)!]["props"])
            
            layoutLevel.padding = padding
        
            
        
        return layoutLevel
    
    
    }

    func setupProperties(subjson:[JSON] , index:String) -> FLXView {
        
    
        
        
        let titleLevel = FLXView()
        
        
            //Text Color
            let textColor = subjson[Int(index)!]["props"]["text-color"].stringValue
            
            let textColorValue = textColor.replacingOccurrences(of: "#", with: "")
            

            
            //Text Title
            var titleText = subjson[Int(index)!]["props"]["text"].stringValue.replacingOccurrences(of: "${", with: "")
        
            titleText = titleText.replacingOccurrences(of: "}", with: "")
            
            
            let title = Label(text: titleText, align: .left, appearance: subjson[Int(index)!]["props"]["appearance"].stringValue , dim : subjson[Int(index)!]["props"]["dim"].stringValue )
            
            let margins = _Margin(margin: subjson[Int(index)!]["props"])
            
            
            title.flx_margins = margins
            
            title.textColor = UIColor(hex:textColorValue)
            
            titleLevel.addSubview(title)
            
        

        return titleLevel
    }
    
    
    
}




//READ THE COLOR FROM HEX TO RGB

/*extension UIColor {
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

*/
