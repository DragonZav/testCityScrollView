//
//  CityView.swift
//  testSearch
//
//  Created by Chris Augg on 2/29/16.
//  Copyright © 2016 Auggie Doggie iOSware. All rights reserved.
//

import UIKit

class CityView: UIView {
    
    var cityName = "City Not Available"
    var weatherLightColor:UIColor = UIColor.lightGrayColor()
    var weatherDarkColor:UIColor = UIColor.darkGrayColor()
    
    enum weatherColors: Int {  //probably make a model class for weather colors and place this there
        case Sunny, Rainy, Windy;
        
        func weatherColor()-> (light: UIColor, dark: UIColor) {
            switch (self) {
            case .Sunny:
                let light = UIColor(red: 255/255.0, green: 253/255.0, blue: 231/255.0, alpha: 1.000)
                let dark = UIColor(red: 253/255.0, green: 216/255.0, blue: 53/255.0, alpha: 1.000)
                return (light, dark)
            case .Rainy:
                let light = UIColor(red: 185/255.0, green: 246/255.0, blue: 202/255.0, alpha: 1.000)
                let dark = UIColor(red: 0/255.0, green: 200/255.0, blue: 83/255.0, alpha: 1.000)
                return (light, dark)
            case .Windy:
                let light = UIColor(red: 227/255.0, green: 242/255.0, blue: 253/255.0, alpha: 1.000)
                let dark = UIColor(red: 13/255.0, green: 71/255.0, blue: 161/255.0, alpha: 1.000)
                return (light, dark)
            }
        }
    }

    
    override init (frame : CGRect) {
        super.init(frame : frame)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    convenience init(frame: CGRect, cityName: String) {
        self.init(frame: frame)
        
        let size: CGSize = self.bounds.size
        
        let width = size.width;
        //let height = size.height;
        self.cityName = cityName
        // lat/long
        // weather info request
        // light and dark colors assigned based on weather for the city
        // but I am just going to randomize it for now
        let unsignedCount = UInt32(2)
        let unsignedRandomNumber = arc4random_uniform(unsignedCount)
        let randomNumber = Int(unsignedRandomNumber)
        
        switch (randomNumber) {
        
        case 0:
            weatherLightColor = weatherColors.Sunny.weatherColor().light
            weatherDarkColor = weatherColors.Sunny.weatherColor().dark
        case 1:
            weatherLightColor = weatherColors.Rainy.weatherColor().light
            weatherDarkColor = weatherColors.Rainy.weatherColor().dark
        case 2:
            weatherLightColor = weatherColors.Windy.weatherColor().light
            weatherDarkColor = weatherColors.Windy.weatherColor().dark
        default:
            print("No weather data")
        }
        
        
        
        let newLbl = UILabel(frame: CGRectMake(20, 20, width - 40, 50))
        newLbl.text = self.cityName
        newLbl.textAlignment = .Center
        newLbl.backgroundColor = UIColor.grayColor()
        newLbl.textColor = UIColor(colorLiteralRed: 255/255.0, green: 193/255.0, blue: 7/255.0, alpha: 1.0)
        
        addSubview(newLbl)

    }
    
    


    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Background View
        
        let context = UIGraphicsGetCurrentContext()
        
        //// Gradient Declarations
        let weatherGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [weatherLightColor.CGColor, weatherDarkColor.CGColor], [0, 1])
        
        //// Background Drawing
        let backgroundPath = UIBezierPath(rect: CGRectMake(0, 0, self.frame.width, self.frame.height))
        CGContextSaveGState(context)
        backgroundPath.addClip()
        CGContextDrawLinearGradient(context, weatherGradient,
            CGPointMake(160, 0),
            CGPointMake(160, 568),
            [.DrawsBeforeStartLocation, .DrawsAfterEndLocation])
        
        
    }
}
