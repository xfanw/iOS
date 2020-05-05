//
//  File.swift
//  XWANG_FinalProj
//
//  Created by Frank Wang on 3/11/20.
//  Copyright © 2020 Frank Wang. All rights reserved.
//

import Foundation
import UIKit
enum ShapeType: String {
    case Line = "Line"
    case Ellipse = "Ellipse"
    case Rectangle = "Rectangle"
    case circle = "Circle"
    case square = "Square"
}

let shapes: [ShapeType] =
    [ .Line,
      .Ellipse,
      .Rectangle,
      .circle,
      .square
    ]


enum DrawType: String {
    case fill = "Filled in"
    case outline = "Outline"
    case inOut = "In & Out"
}
let drawType : [DrawType] = [
    .fill,
    .outline,
    .inOut
]
enum DrawColor : String{
   case blue = "Blue"
   case green = "Green"
   case orange = "Orange"
   case red = "Red"
   case black = "Black"
   case yellow = "Yellow"
   case cyan = "Cyan"
   case purple = "Purple"
}
let drawColor : [DrawColor] = [
    .blue,
    .green,
    .orange,
    .red,
    .black,
    .yellow,
    .cyan,
    .purple
]

let ColorConverter : [DrawColor : CGColor] = [
    .blue   : UIColor.blue.cgColor,
    .green  : UIColor.green.cgColor,
    .orange : UIColor.orange.cgColor,
    .red    : UIColor.red.cgColor,
    .black  : UIColor.black.cgColor,
    .yellow : UIColor.yellow.cgColor,
    .cyan   : UIColor.cyan.cgColor,
    .purple : UIColor.purple.cgColor

]

class Shape{
    var fillColor:CGColor
    var strokeColor:CGColor
    var drawMode: DrawType
    init(_ fColor:CGColor, _ bColor:CGColor, _ drawType: DrawType){
        self.fillColor = fColor
        self.strokeColor = bColor
        self.drawMode = drawType
    }
    func drawStrategy(from startX: Int, _ startY:Int, with width:Int, _ height: Int)->(){
        switch drawMode {
            case .fill :
                return drawShapeFilled(from: startX, startY, with: width, height)
            case .outline :
                return drawShapeOutline(from: startX, startY, with: width, height)
            case .inOut :
                return drawShapeInOut(from: startX, startY, with: width, height)
        }
    }
    func drawShapeFilled(from _:Int, _:Int, with _:Int, _:Int){}
    func drawShapeOutline(from _:Int, _:Int, with _:Int, _:Int){}
    func drawShapeInOut(from _:Int, _:Int, with _:Int, _:Int){}
}

class LineShape : Shape{
    override  init(_ fColor:CGColor, _ bColor:CGColor, _ drawType: DrawType){
        super.init(fColor, bColor, drawType)
    }
    override func drawShapeFilled(from startX: Int, _ startY:Int, with width:Int, _ height: Int) {
        if let context = UIGraphicsGetCurrentContext(){
            context.setStrokeColor(fillColor)
            context.setLineWidth(2)
            context.move(to: CGPoint(x: startX, y: startY))
            context.addLine(to: CGPoint(x: startX + width, y: startY + height))
            context.strokePath()
            reset()
        }
    }
    override func drawShapeOutline(from startX: Int, _ startY:Int, with width:Int, _ height: Int){
        if let context = UIGraphicsGetCurrentContext(){
            context.setStrokeColor(strokeColor)
            context.setLineWidth(4)
            context.setLineDash(phase:0, lengths: [4,4])
            context.move(to: CGPoint(x: startX, y: startY))
            context.addLine(to: CGPoint(x: startX + width, y: startY + height))
            context.strokePath()
            reset()
        }
    }
    override func drawShapeInOut(from startX: Int, _ startY:Int, with width:Int, _ height: Int){
        if let context = UIGraphicsGetCurrentContext(){
            context.setStrokeColor(fillColor)
            context.setLineWidth(2)
            context.setLineDash(phase:0, lengths: [2,8])
            context.move(to: CGPoint(x: startX, y: startY))
            context.addLine(to: CGPoint(x: startX + width, y: startY + height))
            context.strokePath()
            reset()
        }
    }
    func reset(){
        if let context = UIGraphicsGetCurrentContext(){
            context.setLineWidth(2)
            context.setLineDash(phase:0, lengths: [])
        }
    }
}

class EllipseShape : Shape{
    override  init(_ fColor:CGColor, _ bColor:CGColor, _ drawType: DrawType){
        super.init(fColor, bColor, drawType)
    }
    override func drawShapeFilled(from startX: Int, _ startY:Int, with width:Int, _ height: Int) {
        if let context = UIGraphicsGetCurrentContext(){
            context.setFillColor(fillColor)
            let rect = CGRect(x: startX, y: startY, width: width, height: height)
            context.fillEllipse(in: rect)
        }
    }
    override func drawShapeOutline(from startX: Int, _ startY:Int, with width:Int, _ height: Int){
        if let context = UIGraphicsGetCurrentContext(){
            context.setStrokeColor(strokeColor)
            let rect = CGRect(x: startX, y: startY, width: width, height: height)
            context.strokeEllipse(in: rect)
        }
    }
    override func drawShapeInOut(from startX: Int, _ startY:Int, with width:Int, _ height: Int){
        if let context = UIGraphicsGetCurrentContext(){
            context.setStrokeColor(strokeColor)
            context.setFillColor(fillColor)
            let rect = CGRect(x: startX, y: startY, width: width, height: height)
            context.fillEllipse(in: rect)
            context.strokeEllipse(in: rect)
        }
    }
}

class CircleShape : Shape{
    override  init(_ fColor:CGColor, _ bColor:CGColor, _ drawType: DrawType){
        super.init(fColor, bColor, drawType)
    }
    override func drawShapeFilled(from startX: Int, _ startY:Int, with width:Int, _ height: Int) {
        if let context = UIGraphicsGetCurrentContext(){
            context.setFillColor(fillColor)
            let rect = CGRect(x: startX, y: startY, width: height, height: height)
            context.fillEllipse(in: rect)
        }
    }
    override func drawShapeOutline(from startX: Int, _ startY:Int, with width:Int, _ height: Int){
        if let context = UIGraphicsGetCurrentContext(){
            context.setStrokeColor(strokeColor)
            let rect = CGRect(x: startX, y: startY, width: height, height: height)
            context.strokeEllipse(in: rect)
        }
    }
    override func drawShapeInOut(from startX: Int, _ startY:Int, with width:Int, _ height: Int){
        if let context = UIGraphicsGetCurrentContext(){
            context.setStrokeColor(strokeColor)
            context.setFillColor(fillColor)
            let rect = CGRect(x: startX, y: startY, width: height, height: height)
            context.fillEllipse(in: rect)
            context.strokeEllipse(in: rect)
        }
    }
}
class RectShape : Shape{
    override  init(_ fColor:CGColor, _ bColor:CGColor, _ drawType: DrawType){
        super.init(fColor, bColor, drawType)
    }
    override func drawShapeFilled(from startX: Int, _ startY:Int, with width:Int, _ height: Int) {
        if let context = UIGraphicsGetCurrentContext(){
            context.setFillColor(fillColor)
            let rect = CGRect(x: startX, y: startY, width: width, height: height)
            context.fill(rect)
        }
    }
    override func drawShapeOutline(from startX: Int, _ startY:Int, with width:Int, _ height: Int){
        if let context = UIGraphicsGetCurrentContext(){
            context.setStrokeColor(strokeColor)
            let rect = CGRect(x: startX, y: startY, width: width, height: height)
            context.stroke(rect)
        }
    }
    override func drawShapeInOut(from startX: Int, _ startY:Int, with width:Int, _ height: Int){
        if let context = UIGraphicsGetCurrentContext(){
            context.setStrokeColor(strokeColor)
            context.setFillColor(fillColor)
            let rect = CGRect(x: startX, y: startY, width: width, height: height)
            context.fill(rect)
            context.stroke(rect)
        }
    }
}

class SquareShape : Shape{
    override  init(_ fColor:CGColor, _ bColor:CGColor, _ drawType: DrawType){
        super.init(fColor, bColor, drawType)
    }
    override func drawShapeFilled(from startX: Int, _ startY:Int, with width:Int, _ height: Int) {
        if let context = UIGraphicsGetCurrentContext(){
            context.setFillColor(fillColor)
            let rect = CGRect(x: startX, y: startY, width: height, height: height)
            context.fill(rect)
        }
    }
    override func drawShapeOutline(from startX: Int, _ startY:Int, with width:Int, _ height: Int){
        if let context = UIGraphicsGetCurrentContext(){
            context.setStrokeColor(strokeColor)
            let rect = CGRect(x: startX, y: startY, width: height, height: height)
            context.stroke(rect)
        }
    }
    override func drawShapeInOut(from startX: Int, _ startY:Int, with width:Int, _ height: Int){
        if let context = UIGraphicsGetCurrentContext(){
            context.setStrokeColor(strokeColor)
            context.setFillColor(fillColor)
            let rect = CGRect(x: startX, y: startY, width: height, height: height)
            context.fill(rect)
            context.stroke(rect)
        }
    }
}

class ShapeFactory{
    static func CreateShape(_ shapeType:ShapeType, _ fColor: CGColor, _ bColor: CGColor, _ drawType:DrawType)->Shape{
    switch shapeType{
        case .Line :    return LineShape(fColor, bColor, drawType)
        case .Ellipse:  return EllipseShape(fColor, bColor, drawType)
        case .Rectangle:return RectShape(fColor, bColor, drawType)
        case .circle:   return CircleShape(fColor, bColor, drawType)
        case .square:   return SquareShape(fColor, bColor, drawType)
    }
    }
}
