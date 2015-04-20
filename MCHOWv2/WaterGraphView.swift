//
//  WaterGraphView.swift
//  MCHOWv2
//
//  Created by Gianluca Capraro on 4/10/15.
//  Copyright (c) 2015 think.slate. All rights reserved.
//

import UIKit

    @IBDesignable class WaterGraphView: UIView {
        
        //1 - the properties for the gradient
        //set up so that they can be changed in main storyboard
        @IBInspectable var startColor: UIColor = UIColor.redColor()
        @IBInspectable var endColor: UIColor = UIColor.greenColor()
        
        func getPoints() -> [Double]{
            let url = NSURL(string: "http://mchow.herokuapp.com/petinfo/water/5500")
            var html = ""
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
                html = NSString(data: data, encoding: NSUTF8StringEncoding)!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            }
            
            task.resume()
            while(html.isEmpty) {} //wait for task to finish
            for var index = html.startIndex; index != html.endIndex; index++ {
                if html[index] == "(" {
                    html = html.substringFromIndex(index)
                    break
                }
            }
            
            for var index = html.endIndex.predecessor(); index != html.startIndex; index-- {
                if html[index] == ")" {
                    html = html.substringToIndex(index.successor())
                    break
                }
            }
            
            var vals = [NSDate: Double]()
            
            var date = ""
            var amtStr = ""
            var amt: Double!
            var start = html.startIndex
            var end = html.startIndex
            for var index = html.startIndex; index != html.endIndex; index++ {
                if html[index] == "(" {
                    start = index
                } else if html[index] == "," {
                    //initialize date
                    date = html[start.successor()...index.predecessor()]
                    //                println(date)
                    //set new start index
                    start = index
                } else if html[index] == ")" {
                    amtStr = html[start.successor()...index.predecessor()]
                    //                println(amtStr)
                    amt = (amtStr as NSString).doubleValue
                    //add to dictionary
                    vals[NSDate(dateString: date)] = amt
                }
            }
            
            let cDate = NSDate()
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            var dateStr = formatter.stringFromDate(cDate)
            var graphPoints:[Double?] = []
            let val = vals[NSDate(dateString: dateStr)]
            let calendar = NSCalendar.currentCalendar()
            graphPoints.append(val)
            var i = 1
            while i < 7 {
                let day = calendar.dateByAddingUnit(.CalendarUnitDay, value: -i, toDate: NSDate(), options: nil)
                dateStr = formatter.stringFromDate(day!)
                graphPoints.append(vals[NSDate(dateString: dateStr)])
                i++
            }
            return graphPoints
        }
        
        //Weekly sample data
        //WILL NEED TO REPLACE THIS FOR SERVER DATA
        var graphPoints:[Int] = [4, 2, 6, 4, 5, 8, 3]
        
        override func drawRect(rect: CGRect) {
            
            let width = rect.width
            let height = rect.height
            
            //set up background clipping area
            var path = UIBezierPath(roundedRect: rect,
                byRoundingCorners: UIRectCorner.AllCorners,
                cornerRadii: CGSize(width: 8.0, height: 8.0))
            path.addClip()
            
            //2 - get the current context
            let context = UIGraphicsGetCurrentContext()
            let colors = [startColor.CGColor, endColor.CGColor]
            
            //3 - set up the color space
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            
            //4 - set up the color stops
            let colorLocations:[CGFloat] = [0.0, 1.0]
            
            //5 - create the gradient
            let gradient = CGGradientCreateWithColors(colorSpace,
                colors,
                colorLocations)
            
            //6 - draw the gradient
            var startPoint = CGPoint.zeroPoint
            var endPoint = CGPoint(x:0, y:self.bounds.height)
            CGContextDrawLinearGradient(context,
                gradient,
                startPoint,
                endPoint,
                0)
            
            //POINT PLOTTING
            
            //calculate the x point
            let margin:CGFloat = 20.0
            var columnXPoint = { (column:Int) -> CGFloat in
                //Calculate gap between points
                let spacer = (width - margin*2 - 4) /
                    CGFloat((self.graphPoints.count - 1))
                var x:CGFloat = CGFloat(column) * spacer
                x += margin + 2
                return x
            }
            // calculate the y point
            let topBorder:CGFloat = 60
            let bottomBorder:CGFloat = 50
            let graphHeight = height - topBorder - bottomBorder
            let maxValue = maxElement(graphPoints)
            var columnYPoint = { (graphPoint:Int) -> CGFloat in
                var y:CGFloat = CGFloat(graphPoint) /
                    CGFloat(maxValue) * graphHeight
                y = graphHeight + topBorder - y // Flip the graph
                return y
            }
            
            // draw the line graph
            UIColor.whiteColor().setFill()
            UIColor.whiteColor().setStroke()
            
            //set up the points line
            var graphPath = UIBezierPath()
            //go to start of line
            graphPath.moveToPoint(CGPoint(x:columnXPoint(0),
                y:columnYPoint(graphPoints[0])))
            
            //add points for each item in the graphPoints array
            //at the correct (x, y) for the point
            for i in 1..<graphPoints.count {
                let nextPoint = CGPoint(x:columnXPoint(i),
                    y:columnYPoint(graphPoints[i]))
                graphPath.addLineToPoint(nextPoint)
            }
            //graphPath.stroke()
            
            //Create the clipping path for the graph gradient
            
            //1 - save the state of the context
            CGContextSaveGState(context)
            
            //2 - make a copy of the path
            var clippingPath = graphPath.copy() as UIBezierPath
            
            //3 - add lines to the copied path to complete the clip area
            clippingPath.addLineToPoint(CGPoint(
                x: columnXPoint(graphPoints.count - 1),
                y:height))
            clippingPath.addLineToPoint(CGPoint(
                x:columnXPoint(0),
                y:height))
            clippingPath.closePath()
            
            //4 - add the clipping path to the context
            clippingPath.addClip()
            
            let highestYPoint = columnYPoint(maxValue)
            startPoint = CGPoint(x:margin, y: highestYPoint)
            endPoint = CGPoint(x:margin, y:self.bounds.height)
            
            CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0)
            CGContextRestoreGState(context)
            
            //draw the line on top of the clipped gradient
            graphPath.lineWidth = 2.0
            graphPath.stroke()
            
            //Draw the circles on top of graph stroke
            //DRAW DATA POINTS
            for i in 0..<graphPoints.count {
                var point = CGPoint(x:columnXPoint(i), y:columnYPoint(graphPoints[i]))
                point.x -= 5.0/2
                point.y -= 5.0/2
                
                let circle = UIBezierPath(ovalInRect:
                    CGRect(origin: point,
                        size: CGSize(width: 5.0, height: 5.0)))
                circle.fill()
            }
            
            //Draw horizontal graph lines on the top of everything
            var linePath = UIBezierPath()
            
            //top line
            linePath.moveToPoint(CGPoint(x:margin, y: topBorder))
            linePath.addLineToPoint(CGPoint(x: width - margin,
                y:topBorder))
            
            //center line
            linePath.moveToPoint(CGPoint(x:margin,
                y: graphHeight/2 + topBorder))
            linePath.addLineToPoint(CGPoint(x:width - margin,
                y:graphHeight/2 + topBorder))
            
            //bottom line
            linePath.moveToPoint(CGPoint(x:margin,
                y:height - bottomBorder))
            linePath.addLineToPoint(CGPoint(x:width - margin,
                y:height - bottomBorder))
            let color = UIColor(white: 1.0, alpha: 0.3)
            color.setStroke()
            
            linePath.lineWidth = 1.0
            linePath.stroke()

        }
}
