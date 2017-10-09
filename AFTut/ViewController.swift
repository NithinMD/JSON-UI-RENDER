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



open class Button: UIButton {
    public convenience init(label: String) {
        self.init()
        
        setTitle(label, for: UIControlState())
        layer.cornerRadius = 5
    }
}

open class HeadLine: UILabel {
    
    public convenience init(text string: String, align: NSTextAlignment = .left) {
        self.init()
        
        font = UIFont(name: "Avenir Next", size: 24)
        numberOfLines = 0
        text = string
        
    }
    
    
}

open class SubHead: UILabel {
    
    public convenience init(text string: String, align: NSTextAlignment = .left) {
        self.init()
        
        font = UIFont(name: "Avenir Next", size: 16)
        numberOfLines = 2
        text = string
        
    }
    
    
}

open class Label: UILabel {
    
    public convenience init(text string: String, align: NSTextAlignment = .left, fontSize: CGFloat = 20) {
        self.init()
        
        font = UIFont(name: "Avenir Next", size: fontSize)
        numberOfLines = 0
        text = string
        
    }
    
    
}

open class Separator: UIView {
    public convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        
        backgroundColor = UIColor(white: 0.92, alpha: 1)
    }
    
}

open class Tag: UILabel {
    static let Padding = UIEdgeInsets(top: 3, left: 5, bottom: 2, right: 5)
    
    public convenience init(name: String) {
        self.init()
        
        font = UIFont(name: "Avenir Next", size: 16)
        layer.backgroundColor = UIColor(hue: 0.3, saturation: 0.5, brightness: 0.8, alpha: 1).cgColor
        layer.borderColor = UIColor(white: 0.92, alpha: 1).cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 4
        text = name
        textColor = UIColor.white
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        var result = super.sizeThatFits(size)
        
        result.width += Tag.Padding.left + Tag.Padding.right
        result.height += Tag.Padding.top + Tag.Padding.bottom
        
        return result
    }
    
    open override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, Tag.Padding))
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    let flexView : FLXView = FLXView()
    
    var margin_top : Int = 0
    var margin_bottom : Int = 0
    var margin_left : Int = 0
    var margin_right : Int = 0
    
    var padding_top : CGFloat = 0.0
    var padding_bottom : CGFloat = 0.0
    var padding_left : CGFloat = 0.0
    var padding_right : CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                
                
                if let object = json.dictionary {
                    // json is a dictionary
                    
                    
                    if (object["item"] == "root") {
                        
                        // First Level Children
                        let children = object["children"]
                        
                        
                        for (_ , Json) in children! {
                            
                            
                            
                            if (Json["item"] == "af-layout") {
                                
                                let direction = Json["props"]["direction"]
                                
                                if (direction == "column") {
                                    flexView.direction = .column
                                }
                                else{
                                    flexView.direction = .row
                                }
                                
                                
                                
                                
                                for (_,json) in Json["children"]{
                                   
                                    
                                    if (json["item"] == "af-layout") {
                                        
                                        let direction = json["props"]["direction"]
                                        
                                        
                                        let secondLevel = FLXView()
                                        secondLevel.childAlignment = .start
                                        
                                        if (direction == "column") {
                                            secondLevel.direction = .column
                                        }
                                        else{
                                            secondLevel.direction = .row
                                        }
                                        
                                        
                                        
                                        
                                        
                                        if (Json["children"][0]["props"]["padding"] != nil){
                                            
                                            padding_top = CGFloat(json["props"]["padding"].intValue)
                                            padding_bottom = CGFloat(json["props"]["padding"].intValue)
                                            padding_right = CGFloat(json["props"]["padding"].intValue)
                                            padding_left = CGFloat(json["props"]["padding"].intValue)
                                            
                                        }
                                        else{
                                            padding_top = CGFloat(json["props"]["padding-top"].intValue)
                                            padding_bottom = CGFloat(json["props"]["padding-bottom"].intValue)
                                            padding_right = CGFloat(json["props"]["padding-right"].intValue)
                                            padding_left = CGFloat(json["props"]["padding-left"].intValue)
                                        }
                                        
                                        
                                        let margins = label_Margin(margin: Json["children"][0]["props"])
                                        
                                        secondLevel.flx_margins = margins
                                        
                                        //Text Color
                                        let textColor = json["children"][0]["props"]["text-color"].stringValue
                                        
                                        let textColorValue = textColor.replacingOccurrences(of: "#", with: "")
                                        
                                        
                                        
                                        //Text Title
                                        var titleText = json["children"][0]["props"]["text"].stringValue.replacingOccurrences(of: "${", with: "")
                                        
                                        titleText = titleText.replacingOccurrences(of: "}", with: "")
                                        
                                        
                                        //CHeck Appearance type
                                        if json["children"][0]["props"]["appearance"] == "headline" {
                                            
                                            
                                            let title = HeadLine(text: titleText, align: .left)
                                            
                                            
                                            let margins = label_Margin(margin: json["children"][0]["props"])
                                            
                                            title.flx_margins = margins
                                            
                                            
                                            title.textColor = UIColor(hex:textColorValue)
                                            
                                            secondLevel.addSubview(title)
                                        }
                                        else if json["children"][0]["props"]["appearance"] == "subhead" {
                                            let title = SubHead(text: titleText, align: .left)
                                            
                                            let margins = label_Margin(margin: json["children"][0]["props"])
                                            
                                        
                                            title.flx_margins = margins
                                        
                                            title.textColor = UIColor(hex:textColorValue)
                                            
                                            secondLevel.addSubview(title)
                                        }
                                        else{
                                            let title = Label(text: titleText, align: .left,fontSize: 20)
                                            
                                            let margins = label_Margin(margin: json["children"][0]["props"])
                                            
                                            
                                            title.flx_margins = margins
                                            
                                            title.textColor = UIColor(hex:textColorValue)
                                            
                                            secondLevel.addSubview(title)
                                        }
                                        
                                       
                                        
                                        
                                        secondLevel.padding = FLXPaddingMake(padding_top, padding_right, padding_bottom, padding_left)
                                        
                                        let bgColor = json["props"]["bg-color"].stringValue
                                        
                                        if (!bgColor.isEmpty) {
                                            let bgColorValue = bgColor.replacingOccurrences(of: "#", with: "")
                                            
                                            secondLevel.backgroundColor = UIColor(hex:bgColorValue)
                                            
                                            
                                        }
                                        
                                        
                                        
                                        flexView.addSubview(secondLevel)
                                        
                                        // SUB titles
                                        
                                        for (index,_) in json["children"]{
                                            
                                            
                                               let subheadView = setupProperties(subjson: json["children"],index: index)
                                            
                                        flexView.addSubview(subheadView)
                                            
                                        }
                                        
                                        
                                        
                                    }
                                }
                                
                                
                            }
                        }
                        
                        
                        
                        
                        scrollView.addSubview(flexView)
                    }
                    
                    
                    
                } else if let object = json.array {
                    // json is an array
                    print("ARRAY")
                    
                    
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
    
    
    
    
    //SET  MARGINS
    func label_Margin(margin:JSON) -> (FLXMargins)  {
        
        print("margin-left")
        print(margin)
        
        
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
        
        
        print(padding["padding"])
        
        
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
    
    
    
    //ALERTVIEW
    
    func showAlert(_ sender:UITapGestureRecognizer){
        // do other task
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    //Check Null or not 
    
    func checkNull(value:AnyObject) -> String
    {
        if(value as! NSObject == NSNull() || value as! String == "")
        {
            return "NULL"
        }
        else
        {
            return value as! String
        }
    }
    
    
    //Setup Properties of subHeading and layout
    
    func setupProperties(subjson:JSON , index:String) -> FLXView {
        
        let thirdLevel = FLXView()
        if (subjson[Int(index)!]["item"] == "af-layout") {
            
            
            
            //Layout Click event
            
            if subjson[Int(index)!]["props"]["af-onclick"].isEmpty {
                let gesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.showAlert(_:)))
            
                thirdLevel.addGestureRecognizer(gesture)
            }
            
            let margins = label_Margin(margin: subjson[Int(index)!]["props"])
            
            
            thirdLevel.flx_margins = margins

            
        }
        let jsonValue = subjson[Int(index)!]["children"][0]["props"]["text"].stringValue
        
        let textValueCheck = checkNull(value: jsonValue as AnyObject)
        
        if (textValueCheck != "NULL") {
            
            
            let direction = subjson[Int(index)!]["children"][0]["props"]["direction"]
            
            
            
            
            thirdLevel.childAlignment = .start
            
            if (direction == "column") {
                thirdLevel.direction = .column
            }
            else{
                thirdLevel.direction = .row
            }
            
            
            
            
            
            
            var subtitleText = subjson[Int(index)!]["children"][0]["props"]["text"].stringValue.replacingOccurrences(of: "${", with: "")
            
            subtitleText = subtitleText.replacingOccurrences(of: "}", with: "")
            
            let textColor = subjson["props"]["text-color"].stringValue
            
            let textColorValue = textColor.replacingOccurrences(of: "#", with: "")
            
            let subtitle = Label(text: subtitleText, align: .left,fontSize: 10)
            
            subtitle.numberOfLines = 0;
            
            subtitle.textColor = UIColor(hex:textColorValue)
            subtitle.textAlignment = .left
            
            thirdLevel.addSubview(subtitle)
            
            
            print("SUB  " , subjson[Int(index)!]["children"][0]["props"]["margin-left"])
            let margins = label_Margin(margin: subjson[Int(index)!]["children"][0]["props"])
            
            
            subtitle.flx_margins = margins
            
            
            if (subjson["props"]["padding"] != nil){
                
                padding_top = CGFloat(subjson[Int(index)!]["children"][0]["props"]["padding"].intValue)
                padding_bottom = CGFloat(subjson[Int(index)!]["children"][0]["props"]["padding"].intValue)
                padding_right = CGFloat(subjson[Int(index)!]["children"][0]["props"]["padding-right"].intValue)
                padding_left = CGFloat(subjson[Int(index)!]["children"][0]["props"]["padding-left"].intValue)
                
            }

            //subtitle.padding = FLXPaddingMake(padding_top, padding_right, padding_bottom, padding_left)
            
            
            let bgColor = subjson[Int(index)!]["props"]["bg-color"].stringValue
            
            if (!bgColor.isEmpty) {
                let bgColorValue = bgColor.replacingOccurrences(of: "#", with: "")
                
                thirdLevel.backgroundColor = UIColor(hex:bgColorValue)
                
                
            }
            
            
            //flexView.addSubview(thirdLevel)
            
        }

        return thirdLevel
    }
    
    
    
}



//Hex to RGB UIColor

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


