//
//  CKGraphView.swift
//  CoreG
//
//  Created by 钰龙徐 on 2016/10/12.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

import UIKit

@IBDesignable class CKGraphView: UIView {

    @IBInspectable var startColor: UIColor = UIColor.red
    @IBInspectable var endColor: UIColor = UIColor.green
    
    var graphPoints: [Int] = [4, 2, 6, 4, 5, 8, 3]
    
    
    override func draw(_ rect: CGRect) {
        
        let ctx = UIGraphicsGetCurrentContext()
        let colors = [startColor.cgColor, endColor.cgColor]
        //色域
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let colorLoactions: [CGFloat] = [0.0, 1.0]
        //渐变色
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLoactions)
        //颜色起始位置
        var startPoint = CGPoint.zero
        var endPoint = CGPoint(x: 0, y: rect.height)
        
        ctx?.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: .drawsBeforeStartLocation)
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8))
        let shapelayer = CAShapeLayer()
        shapelayer.path = path.cgPath
        
        layer.mask = shapelayer
        
        
        let margin: CGFloat = 20
        
        let columnXPoint =  { (column: Int) -> CGFloat in
            let spacer = (rect.width - margin * 2 - 4) / CGFloat(self.graphPoints.count - 1)
            let x = margin + 2 + CGFloat(column) * spacer
            return x
        }
        
        let topBorder:CGFloat = 60
        let bottomBorder:CGFloat = 50
        let graphHeight = rect.height - topBorder - bottomBorder
        let maxValue = graphPoints.max()!
        let columnYPoint = { (graphPoint:Int) -> CGFloat in
            var y:CGFloat = CGFloat(graphPoint) /
                CGFloat(maxValue) * graphHeight
            y = graphHeight + topBorder - y // Flip the graph
            return y
        }
        
        // draw the line graph
        
        UIColor.white.set()
        
        //set up the points line
        let graphPath = UIBezierPath()
        //go to start of line
        graphPath.move(to: CGPoint(x:columnXPoint(0),
                                      y:columnYPoint(graphPoints[0])))
        
        //add points for each item in the graphPoints array
        //at the correct (x, y) for the point
        for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x:columnXPoint(i),
                                    y:columnYPoint(graphPoints[i]))
            graphPath.addLine(to: nextPoint)
        }
        
        
        ctx?.saveGState()
        
        let clippingPath = graphPath.copy() as! UIBezierPath
        
        clippingPath.addLine(to: CGPoint(x: columnXPoint(graphPoints.count - 1),
                                         y: rect.height))
        clippingPath.addLine(to: CGPoint(x: columnXPoint(0), y: rect.height))
        
        clippingPath.close()
        
        clippingPath.addClip()
        
        let highestYPoint = columnYPoint(maxValue)
        startPoint = CGPoint(x: margin, y: highestYPoint)
        endPoint = CGPoint(x: margin, y: self.bounds.height)
        
        ctx?.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: .drawsBeforeStartLocation)
        
        ctx?.restoreGState()
        
        graphPath.lineWidth = 2
        graphPath.stroke()
    }
}
