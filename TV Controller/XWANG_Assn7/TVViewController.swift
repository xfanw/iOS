//
//  FirstViewController.swift
//  XWANG_Assn7
//
//  Created by Frank Wang on 2/28/20.
//  Copyright © 2020 Frank Wang. All rights reserved.
//

import UIKit

class TVViewController: UIViewController {

    
    
    // TV Panel
    @IBOutlet weak var Power: UILabel!
    @IBOutlet weak var Volume: UILabel!
    @IBOutlet weak var Channel: UILabel!
    
    // Controller Panel
    @IBOutlet weak var PowerSwitch: UISwitch!
    @IBOutlet weak var VolumeSlider: UISlider!
    @IBOutlet weak var ChannelStepper: UIStepper!
    @IBOutlet weak var SegmentedFavorate: UISegmentedControl!
    
    // Buttons 0~9
    
    @IBOutlet var NumButtons: [UIButton]!
    
    // vars
    var currentChannel:Int! = 1
    var chText:String! = ""
    var favorateChannels = [20, 30, 40, 50]
    // Power Switch
    @IBAction func SwitchToggled(_ sender: UISwitch) {
        setAllStatus(sender.isOn);
        Power.text! = sender.isOn ? "ON" :"OFF"
        
    }
    
    // Volume Slider
    @IBAction func VolSilderMoved(_ sender: UISlider) {
        Volume.text = "\(Int(sender.value))"
    }
    
    // Channel Stepper
    @IBAction func ChannelStepperPressed(_ sender: UIStepper) {
        chText = ""
        currentChannel = Int(ChannelStepper.value)
        Channel.text = "\(currentChannel!)"
    }
    
    
    // Segmented Control
    // 7.3 update
    @IBAction func FavorateSelected(_ sender: UISegmentedControl) {
        chText = ""
        currentChannel = favorateChannels[sender.selectedSegmentIndex];
        
        Channel.text = "\(currentChannel ?? 1)"
        ChannelStepper.value = Double(currentChannel)
    }
    
    
    @IBAction func NumberButtonPressed(_ sender: UIButton) {
        chText += sender.currentTitle!
        Channel.text = chText
        if (chText.count == 2){
            
            currentChannel = Int(chText)
            if currentChannel == 0 {
                currentChannel += 1
            }
            ChannelStepper.value = Double(currentChannel)
            Channel.text = "\(currentChannel!)"
            chText = ""
        }
    }
    
    func setAllStatus(_ status:Bool){
        VolumeSlider.isEnabled = status
        ChannelStepper.isEnabled = status
        SegmentedFavorate.isEnabled = status
        
        for nums in NumButtons {
            nums.isEnabled = status
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Set up initial value
        // PowerSwitch.isOn = true
        Power.text = PowerSwitch.isOn ? "ON" : "OFF"
        Volume.text = String(Int(VolumeSlider.value))
        Channel.text = String(Int(ChannelStepper.value))
        
        // change stepper to verticle
        //ChannelStepper.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
        
    }
    
    // 7.3 update segmented control and data
    override func viewWillAppear(_ animated: Bool) {
        if positionToSend != nil{
            SegmentedFavorate.setTitle(labelToSend, forSegmentAt: Int(positionToSend!)! - 1 )
            favorateChannels[Int(positionToSend!)! - 1 ] = Int(channelToSend)!
            SegmentedFavorate.selectedSegmentIndex = UISegmentedControl.noSegment
        }
    }



}

