//
//  ViewController.swift
//  GlowGridDisplayTest
//
//  Created by Bambi Brewer on 6/26/20.
//  Copyright © 2020 Bambi Brewer. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController {
    
    var topic: Topic = .addition
    
    @IBOutlet var glowBoardDisplay: Display!
    
    @IBOutlet var firstNumberSlider: UISlider!
    @IBOutlet var secondNumberSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        glowBoardDisplay.topic = topic
        
        /* Set up the sliders and the initial values for the GlowBoard display. */
        switch (topic) {
        case .addition:
            firstNumberSlider.minimumValue = 0
            firstNumberSlider.maximumValue = 60
            secondNumberSlider.minimumValue = 0
            secondNumberSlider.maximumValue = 60
            glowBoardDisplay.firstNumber = 0
            glowBoardDisplay.secondNumber = 0
        case .subtraction:
            firstNumberSlider.minimumValue = 0
            firstNumberSlider.maximumValue = 120
            secondNumberSlider.minimumValue = 0
            secondNumberSlider.maximumValue = 120
            glowBoardDisplay.firstNumber = 0
            glowBoardDisplay.secondNumber = 0
        case .multiplication, .division:
            firstNumberSlider.minimumValue = 1
            firstNumberSlider.maximumValue = 12
            secondNumberSlider.minimumValue = 1
            secondNumberSlider.maximumValue = 12
            glowBoardDisplay.firstNumber = 1
            glowBoardDisplay.secondNumber = 1
        case .remainder:
            firstNumberSlider.minimumValue = 1
            firstNumberSlider.maximumValue = 12
            secondNumberSlider.minimumValue = 1
            secondNumberSlider.maximumValue = 144
            glowBoardDisplay.firstNumber = 1
            glowBoardDisplay.secondNumber = 1
        }
    }

    @IBAction func slider1Changed(_ sender: UISlider) {
        glowBoardDisplay.firstNumber = Int(round(sender.value))
        glowBoardDisplay.setNeedsDisplay()
    }
    
    @IBAction func slider2Changed(_ sender: UISlider) {
        glowBoardDisplay.secondNumber = Int(round(sender.value))
        glowBoardDisplay.setNeedsDisplay()
    }
    
}

