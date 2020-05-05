//
//  CanvasView.swift
//  XWANG_FinalProj
//
//  Created by Frank Wang on 3/12/20.
//  Copyright © 2020 Frank Wang. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    
    var toDraw = false
    var shapeList : [Shape] = []
    var backColor: CGColor!
    
    
    // Constants
    let initX: Int = 20
    let initY : Int = 10
    let width : Int = 80
    let height : Int = 60
    let deltaX : Int = 90
    let deltaY : Int = 80
    let itemsInRow = 4
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.*/
    override func draw(_ rect: CGRect) {
        if toDraw{
            let size = shapeList.count
            for i in 0..<size{
                let startX = initX + deltaX * ( i % itemsInRow)
                let startY = initY + deltaY * ( i / itemsInRow)
                shapeList[i].drawStrategy(from:startX, startY, with:width,  height)
            }
        }
    } // end draw
}
