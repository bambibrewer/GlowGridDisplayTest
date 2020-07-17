//
//  MenuViewController.swift
//  GlowGridDisplayTest
//
//  Created by Bambi Brewer on 7/17/20.
//  Copyright © 2020 Bambi Brewer. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var topic: Topic = .addition
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        switch(sender.currentTitle) {
        case "Addition":
            topic = .addition
        case "Subtraction":
            topic = .subtraction
        case "Multiplication":
            topic = .multiplication
        case "Division":
            topic = .division
        case "Division with Remainders":
            topic = .remainder
        default:
            print("can't get here")
        }
        
        performSegue(withIdentifier: "goToTopic", sender: nil)
        
    }
    
    /* This function is called just before the segue to the Display View Controller Scene. */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTopic" {
            let destinationVC = segue.destination as! DisplayViewController
            destinationVC.topic = topic
        }
    }
    
}
