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
       // print(node)
        let secondLevel = FLXView()
        for (index,each) in node {
            
            if node.dictionary != nil {
                
                traverseTree(node: each)
            }
            if let object = node.array {
                
                let subheadView = setupProperties(subjson: object,index: index)
                
                secondLevel.addSubview(subheadView)
                
                
                traverseTree(node: each)
            }
           
            
        }
        
        flexView.addSubview(secondLevel)
        
        scrollView.addSubview(flexView)
        
        
    }
    
    
    
    //SET  MARGINS
    func label_Margin(margin:JSON) -> (FLXMargins)  {
        
        
        
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
    
    
    
    
    
    //Setup Properties of subHeading and layout
    
    func setupProperties(subjson:[JSON] , index:String) -> FLXView {
        
        print(subjson[Int(index)!]["item"] )
        let thirdLevel = FLXView()
        
        if (subjson[Int(index)!]["item"] == "af-layout") {
            
            
            
            //Layout Click event
            
            if subjson[Int(index)!]["props"]["af-onclick"].isEmpty {
                let gesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.showAlert(_:)))
            
                thirdLevel.addGestureRecognizer(gesture)
            }
            
            let margins = label_Margin(margin: subjson[Int(index)!]["props"])
            
            
            thirdLevel.flx_margins = margins

            
            let direction = subjson[Int(index)!]["props"]["direction"]
            
            
            
            thirdLevel.childAlignment = .start
            
            if (direction == "column") {
                thirdLevel.direction = .column
            }
            else{
                thirdLevel.direction = .row
            }
            
            
            
            if (subjson[Int(index)!]["children"][0]["props"]["padding"] != nil){
                
                padding_top = CGFloat(subjson[Int(index)!]["props"]["padding"].intValue)
                padding_bottom = CGFloat(subjson[Int(index)!]["props"]["padding"].intValue)
                padding_right = CGFloat(subjson[Int(index)!]["props"]["padding"].intValue)
                padding_left = CGFloat(subjson[Int(index)!]["props"]["padding"].intValue)
                
            }
            else{
                padding_top = CGFloat(subjson[Int(index)!]["props"]["padding-top"].intValue)
                padding_bottom = CGFloat(subjson[Int(index)!]["props"]["padding-bottom"].intValue)
                padding_right = CGFloat(subjson[Int(index)!]["props"]["padding-right"].intValue)
                padding_left = CGFloat(subjson[Int(index)!]["props"]["padding-left"].intValue)
            }
            
            
            thirdLevel.padding = FLXPaddingMake(padding_top, padding_right, padding_bottom, padding_left)
            
            let bgColor = subjson[Int(index)!]["props"]["bg-color"].stringValue
            
            if (!bgColor.isEmpty) {
                let bgColorValue = bgColor.replacingOccurrences(of: "#", with: "")
                
                thirdLevel.backgroundColor = UIColor(hex:bgColorValue)
                
                
            }
            
            
        }
        else if(subjson[Int(index)!]["item"] == "af-label") {
        
        
            //Text Color
            let textColor = subjson[Int(index)!]["children"][0]["props"]["text-color"].stringValue
            
            let textColorValue = textColor.replacingOccurrences(of: "#", with: "")
            
            
            
            print(subjson[Int(index)!])
            //Text Title
            var titleText = subjson[Int(index)!]["props"]["text"].stringValue.replacingOccurrences(of: "${", with: "")
            
            titleText = titleText.replacingOccurrences(of: "}", with: "")
            
            
            //CHeck Appearance type
            if subjson[Int(index)!]["props"]["appearance"] == "headline" {
                
                
                let title = HeadLine(text: titleText, align: .left)
                
                
                let margins = label_Margin(margin: subjson[Int(index)!]["props"])
                
                title.flx_margins = margins
                
                
                title.textColor = UIColor(hex:textColorValue)
                
                thirdLevel.addSubview(title)
            }
            else if subjson[Int(index)!]["props"]["appearance"] == "subhead" {
                let title = SubHead(text: titleText, align: .left)
                
                let margins = label_Margin(margin: subjson[Int(index)!]["props"])
                
                
                title.flx_margins = margins
                
                title.textColor = UIColor(hex:textColorValue)
                
                thirdLevel.addSubview(title)
            }
            else{
                let title = Label(text: titleText, align: .left,fontSize: 20)
                
                let margins = label_Margin(margin: subjson[Int(index)!]["props"])
                
                
                title.flx_margins = margins
                
                title.textColor = UIColor(hex:textColorValue)
                
                thirdLevel.addSubview(title)
            }
            
        }
        
    

        return thirdLevel
    }
    
    
    
}




//READ THE COLOR FROM HEX TO RGB

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


