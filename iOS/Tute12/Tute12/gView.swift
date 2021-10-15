//
//  gView.swift
//  Tute12
//
//  Created by Muhsana Chowdhury  on 20/1/21.
//

import UIKit
import CoreGraphics

class gView: UIView {

    var currentShapeType: Int = 0
        init(frame: CGRect, shape: Int) {
            super.init(frame: frame)
            self.currentShapeType = shape
            // shapeType was passed by ViewController File
        }
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
       
        
        
        // Only override draw() if you perform custom drawing.
        // An empty implementation adversely affects performance during animation.
        override func draw(_ rect: CGRect) {
            // Drawing code
            
            //draw X
            let contextX = UIGraphicsGetCurrentContext()
            contextX?.setLineWidth(2.0)
            contextX?.setStrokeColor(UIColor.blue.cgColor)
            contextX?.move(to: CGPoint(x:100, y: 100))
            contextX?.addLine(to: CGPoint(x: 200, y: 200))
            contextX?.move(to: CGPoint(x:200, y: 100))
            contextX?.addLine(to: CGPoint(x: 100, y: 200))
            contextX?.strokePath()
            
            //draw rectangle
            let contextY = UIGraphicsGetCurrentContext()
            contextY?.setStrokeColor(UIColor.red.cgColor)
            contextY?.setLineWidth(2.0)
            let rectangle = CGRect(x: 100, y: 100, width: 100, height: 100)
            contextY?.addRect(rectangle)
            contextY?.strokePath()
            
            //draw circle
            let contextZ = UIGraphicsGetCurrentContext()
            contextZ?.setStrokeColor(UIColor.green.cgColor)
            contextZ?.setLineWidth(2.0)
            let circle = CGRect(x: 78, y: 78, width: 142, height: 148)
            contextZ?.addEllipse(in: circle)
            contextZ?.strokePath()
            
        
        }

}

