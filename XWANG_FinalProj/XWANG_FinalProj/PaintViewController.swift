//
//  PaintViewController.swift
//  XWANG_FinalProj
//
//  Created by Frank Wang on 3/10/20.
//  Copyright © 2020 Frank Wang. All rights reserved.
//

import UIKit

class PaintViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var Canvas: CanvasView!
    // MARK: UIPickerViewDataSource
    
    @IBOutlet weak var outLable: UILabel!
    
    @IBOutlet weak var rSlider: UISlider!
    @IBOutlet weak var gSlider: UISlider!
    @IBOutlet weak var bSlider: UISlider!
    
    @IBOutlet weak var rValLable: UILabel!
    @IBOutlet weak var gValLable: UILabel!
    @IBOutlet weak var bValLable: UILabel!
    
    @IBOutlet var rgbLable: [UILabel]!
    var outLineAvaliable : Bool!
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return shapes.count
        }
        if component == 1{
            return drawType.count
        }
        if component == 2{
            return drawColor.count
        }
        return 0
    }
    
    // MARK: UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return shapes[row].rawValue
        }
        if component == 1{
            return drawType[row].rawValue
        }
        if component == 2{
            
            return drawColor[row].rawValue
        }
        return nil
    }
// picker selected
    func pickerView(_ pickerView:UIPickerView, didSelectRow row: Int, inComponent component:Int){
        if drawType[picker.selectedRow(inComponent: 1)] == .inOut || drawType[picker.selectedRow(inComponent: 1)] == .outline{
            setOutLineHidden(false)
        } else{
            setOutLineHidden(true)
        }
    }
    
// set outline rgb
    @IBAction func rSlided(_ sender: UISlider) {
        rValLable.text = "\(Int(sender.value))"
    }
    
    @IBAction func gSlided(_ sender: UISlider) {
        gValLable.text = "\(Int(sender.value))"
    }
    
    @IBAction func bSlided(_ sender: UISlider) {
        bValLable.text = "\(Int(sender.value))"
    }
    
    func setOutLineHidden(_ yes:Bool){
        outLable.isHidden = yes
        
        rSlider.isHidden = yes
        gSlider.isHidden = yes
        bSlider.isHidden = yes
        
        rValLable.isHidden = yes
        gValLable.isHidden = yes
        bValLable.isHidden = yes
        
        for val in rgbLable{
            val.isHidden = yes
        }
        outLineAvaliable = !yes
    }
    
    @IBOutlet weak var countLabel: UILabel!
    @IBAction func DrawShape(_ sender: UIButton) {
        
        if (outLineAvaliable){
            let r = CGFloat(rSlider!.value/255)
            let g = CGFloat(gSlider!.value/255)
            let b = CGFloat(bSlider!.value/255)
            Canvas.backColor = CGColor(srgbRed:r,green:g, blue:b, alpha:1)
        }
        let shape = ShapeFactory.CreateShape(shapes[picker.selectedRow(inComponent: 0)], ColorConverter[drawColor[picker.selectedRow(inComponent: 2)]] ?? UIColor.blue.cgColor, Canvas.backColor ?? UIColor.red.cgColor, drawType[picker.selectedRow(inComponent: 1)])
        if Canvas.shapeList.count >= 20{
            ShowAllert()
        } else{
            countLabel.text = "\(Canvas.shapeList.count + 1)"
           Canvas.shapeList.append(shape)
        }
        
        Canvas.toDraw = true
        Canvas.setNeedsDisplay()

    }
    
    @IBAction func ClearCanvas(_ sender: UIButton) {
        Canvas.shapeList.removeAll()
        Canvas.toDraw = false
        Canvas.setNeedsDisplay()
        countLabel.text = "0"
    }
    
    func ShowAllert(){
        let alertController =
            UIAlertController(title: "Shapes are out of screen",
                              message: "Clear the Canvas to draw more",
                              preferredStyle: .alert)
        
        // Create the action.
        let cancelAction =
            UIAlertAction(title: "OK",
                          style: .cancel,
                          handler: nil)
        alertController.addAction(cancelAction)
        present(alertController,
                animated: true,
                completion: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setOutLineHidden(true)
        rValLable.text = "\(Int(rSlider.value))"
        gValLable.text = "\(Int(gSlider.value))"
        bValLable.text = "\(Int(bSlider.value))"
        countLabel.text = "0"
    }
}
