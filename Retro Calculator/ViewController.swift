//
//  ViewController.swift
//  Retro Calculator
//
//  Created by mitesh soni on 09/06/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

    enum Operations {
        case Divide;
        case Multiply;
        case Plus;
        case Minus;
        case Equals;
        case Empty;
    }
    @IBOutlet weak var outputLabel : UILabel!
    
    var buttonSound : AVAudioPlayer!;
    var runningString = ""
    var leftString = ""
    var rightString = ""
    var result = ""
    var currentOperation = Operations.Empty;
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let audioPath = NSBundle.mainBundle().pathForResource("btn", ofType: "wav");
        let audioUrl = NSURL(fileURLWithPath: audioPath!);
        do{
            try buttonSound = AVAudioPlayer(contentsOfURL: audioUrl);
            buttonSound.prepareToPlay();
        } catch let error as NSError{
            print(error.debugDescription);
        }
        
    }
    
    @IBAction func numberPressed(button : UIButton!){
        play()
        runningString += "\(button.tag)"
        outputLabel.text = runningString;
    }

    @IBAction func onMultiplicationPressed(sender: AnyObject) {
        processOperation(Operations.Multiply)
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operations.Divide)
    }
    
    @IBAction func OnMinusPressed(sender: AnyObject) {
        processOperation(Operations.Minus)
    }

    @IBAction func onPlusPressed(sender: AnyObject) {
        processOperation(Operations.Plus)
    }

    @IBAction func onEqualsPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        play();
        leftString = ""
        rightString = ""
        runningString = ""
        outputLabel.text = ""
        currentOperation = Operations.Empty
    }
    func processOperation(operation : Operations) -> Void {
        play()

        
        if (currentOperation == Operations.Empty){
            leftString = runningString
            runningString = ""
            outputLabel.text = runningString
            if (leftString != ""){
                //For sorting out the error, Suppose if someone presses Any Operation at the first chance.
                currentOperation = operation
            }
        } else{
            if (runningString != ""){
                rightString = runningString
                runningString = ""
                
                if (currentOperation == Operations.Minus){
                    result = "\(Int(leftString)! - Int(rightString)!)"
                } else if (currentOperation == Operations.Plus){
                    result = "\(Int(leftString)! + Int(rightString)!)"
                } else if (currentOperation == Operations.Multiply){
                    result = "\(Int(leftString)! * Int(rightString)!)"
                } else if (currentOperation == Operations.Divide){
                    result = "\(Int(leftString)! / Int(rightString)!)"
                }
                
               
                leftString = result
                outputLabel.text = leftString
                runningString = ""
            }
             currentOperation = operation

        }


    }
    
    func play() -> Void {
        if (buttonSound.playing){
            buttonSound.stop()
        }
        buttonSound.play()
    }
}

