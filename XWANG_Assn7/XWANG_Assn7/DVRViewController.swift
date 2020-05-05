//
//  DVRViewController.swift
//  XWANG_Assn6
//
//  Created by Frank Wang on 2/18/20.
//  Copyright © 2020 Frank Wang. All rights reserved.
//

import UIKit

class DVRViewController: UIViewController {

    @IBOutlet weak var Power: UILabel!
    @IBOutlet weak var Status: UILabel!
    @IBOutlet weak var DVRSwitch: UISwitch!
    @IBOutlet var ControlButtons: [UIButton]!
    
    var playMode = "stopped"
    
    // 3.a turn OFF
    @IBAction func PowerSwitch(_ sender: UISwitch) {
        Power.text! = sender.isOn ? "ON" :"OFF"
        for button in ControlButtons{
            button.isEnabled = sender.isOn
        }
    }
    
    //3.b state
    @IBAction func ButtonPressed(_ sender: UIButton) {
        if ButtonIsValid(sender){
            Status.text = sender.currentTitle
            
            //set up if in play mode
            if Status.text == "Play"{
                playMode = "playing"
            }
            if Status.text == "Stop"{
                playMode = "stopped"
            }
            if Status.text == "Record"{
                playMode = "recording"
            }
        }
    }
    // 3.c d Play mode and stop mode
    func ButtonIsValid(_ sender:UIButton)->Bool{
        var message = " is not availabe when \(playMode)"
        
        if let buttonMessage = sender.currentTitle{
            // 3.c Play mode "Record" is not available
            if playMode == "playing" && buttonMessage == "Record"{
                message = buttonMessage + message
                
                ShowActionSheet(message, "Record", buttonMessage)
                return false
                
            }
            // 3.d << || >> not available when stop or recording
            if playMode != "playing" {
                if buttonMessage == "Pause" || buttonMessage == "Fast Rewind" || buttonMessage == "Fast Forward"{
                    message = buttonMessage + message
                    
                    ShowActionSheet(message, "Play", buttonMessage)
                    return false
                    
                }
            }
            // 3.d if recording play does not work
            if playMode == "recording"{
                if buttonMessage == "Play"{
                    message = buttonMessage + message
                    
                    ShowActionSheet(message, "Play", buttonMessage)
                    return false
                    
                }
            }
        }
        
        return true
    }
    
    
    // 4. when action not possible action sheet will pop up
    func ShowActionSheet(_ message:String, _ mode:String, _ text:String){
        let title = "Button Is Invalid"
        
        let alertController =
            UIAlertController(title: title,
                              message: message,
                              preferredStyle: .actionSheet)
        
        // Create the action.
        let forwordAction =
            UIAlertAction(title: "Change Mode to \(mode)",
                          style: .destructive
                          ){ _ in
                            let confirmAlertController = UIAlertController(title: "Current mode will be stopped.\n Changing mode to \(mode)?",
                         message: nil,
                         preferredStyle: .alert)
                     confirmAlertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: {_ in
                        self.changeMode(mode, text)
                     }))
                     confirmAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                     self.present(confirmAlertController,
                         animated: true,
                         completion: nil)
        }
        
        // 4.a cancel the opration will stay in current state
        let cancelAction =
            UIAlertAction(title: "Cancel",
                          style: .cancel,
                          handler: nil)

        alertController.addAction(forwordAction)
        alertController.addAction(cancelAction)
        
        present(alertController,
                animated: true,
                completion: nil)
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Power.text! = DVRSwitch.isOn ? "ON" :"OFF"
        Status.text! = "Stop"
        // Do any additional setup after loading the view.
    }
    
    // 5. switch to TV/DVR
    @IBAction func SwitchToTV(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
   
    func changeMode(_ mode:String, _ text:String){
        Status.text = text
        if mode == "Play"{
            playMode = "playing"
        }
        if mode == "Record" {
            playMode = "recording"
        }
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
