//
//  ConfigViewController.swift
//  XWANG_Assn7
//
//  Created by Frank Wang on 2/28/20.
//  Copyright © 2020 Frank Wang. All rights reserved.
//

import UIKit

var positionToSend:String?
var labelToSend:String!
var channelToSend:String!

class ConfigViewController: UIViewController {


    
    @IBOutlet weak var chDescription: UITextField!
    @IBOutlet weak var chNumber: UILabel!
    @IBOutlet weak var steppter: UIStepper!
    @IBOutlet weak var channelSegment: UISegmentedControl!
    

 
    // remove keyboard after editing
    @IBAction func EditEnd(_ sender: UITextField) {
         sender.resignFirstResponder()
    }
    @IBAction func TopContainertapped(_ sender: UIControl) {
        chDescription.resignFirstResponder()
    }
    

    // cancel button clear everything
    @IBAction func CancelAction(_ sender: UIButton) {
        channelSegment.selectedSegmentIndex = UISegmentedControl.noSegment
        chDescription.text = ""
        steppter.value = 1
        chNumber.text = "1"
    }
    
    @IBAction func SavePressed(_ sender: UIButton) {
        var validInput = true
        
        // a) check if button selected
        if channelSegment.selectedSegmentIndex == UISegmentedControl.noSegment{
            ShowAllert("Select a channel button")
            validInput = false
        }
        else{
            positionToSend = channelSegment.titleForSegment(at: channelSegment.selectedSegmentIndex)
        }
        
        // b) check if label is valid

        if let label = chDescription.text{
            if (label.count <= 0 || label.count > 4 ){
                ShowAllert("Label should have 1~4 characters")
                validInput = false
            }
            else {
                labelToSend = label
            }
        }
        
        channelToSend = chNumber.text
        // d) Action and alert
        if validInput{
            ShowActionSheet("Button: \(positionToSend!)\nLabel: \(labelToSend!)\nChannel: \(channelToSend!)")
            
        }
    }
    
    // c) change channel text when stepper pressed
    @IBAction func StepperPressed(_ sender: UIStepper) {
        chNumber.text = "\(Int(sender.value))"
    }
    
    // SctionSheet
    func ShowActionSheet(_ message:String){
        let title = "Setting up favorate channels"
        
        let alertController =
            UIAlertController(title: title,
                              message: message,
                              preferredStyle: .actionSheet)
        

        let cancelAction =
              UIAlertAction(title: "Cancel",
                            style: .cancel){ _ in
                              positionToSend = nil
          }
        
        let forwordAction =
            UIAlertAction(title: "Yes, go ahead",
                          style: .destructive
                          , handler: nil)
        
  

        alertController.addAction(forwordAction)
        alertController.addAction(cancelAction)
        
        present(alertController,
                animated: true,
                completion: nil)
        

    }
    // Show Allert
    func ShowAllert(_ message:String){
        let alertController =
            UIAlertController(title: "Invalid Input",
                              message: message,
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
        chNumber.text = "\(Int(steppter.value))"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
