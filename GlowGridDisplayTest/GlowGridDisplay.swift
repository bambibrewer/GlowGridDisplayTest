//
//  Display.swift
//  GlowGridDisplayTest
//
//  Created by Bambi Brewer on 6/26/20.
//  Copyright © 2020 Bambi Brewer. All rights reserved.
//

import UIKit



@IBDesignable
class GlowGridDisplay: UIView {
    
    var topic: Topic = .addition    // Default is addition
    
    // Set up the dimensions of the grid for different topics
    let numRows = 12
    var numColumns: Int {
        get {
            if ((topic == .addition) || (topic == .subtraction)) {
                return 10
            } else {
                return 12
            }
        }
    }

    // Set up the colors of the grid for different topics
    let defaultColor = UIColor.white
    var firstColor: UIColor {
        get {
            switch (topic) {
            case .addition:
                return UIColor.blue
            case .subtraction:
                return UIColor.green
            case .multiplication:
                return UIColor.yellow
            case .division, .remainder:
                return UIColor.systemTeal
            }
        }
    }
    var secondColor: UIColor {
        get {
            switch (topic) {
            case .addition:
                return UIColor.red
            case .subtraction:
                return UIColor.gray
            case .multiplication, .division:    // second color not used here
                return defaultColor
            case .remainder:
                return UIColor.systemPink
            }
        }
    }
    
    // Define the variables that determine which LEDs on the display are lit. The display is redrawn when these variables change
    @IBInspectable var firstNumber: Int = 0 {
      didSet {
        setNeedsDisplay()
      }
    }
    
    @IBInspectable var secondNumber: Int = 0 {
      didSet {
        setNeedsDisplay()
      }
    }
    

    // Draw the custom display
    override func draw(_ rect: CGRect) {
        
        let height = rect.size.height
        let width = rect.size.width
        
        /* We need to find the size of each square in the array based on the height and width of the view. squareSize1 is the biggest size that would fit in the width, and squareSize2 is the biggest size that would fit in the columns. There is a gap of 0.25*squareSize between squares. */
        let squareSize1 = width/(1.25*CGFloat(numColumns) - 0.25)
        let squareSize2 = height/(1.25*CGFloat(numRows) - 0.25)
        let squareSize = min(squareSize1, squareSize2)
        
        /* Create an array for my rectangles */
        var rectangleArray = Array(repeating: Array(repeating: CGRect(), count: numColumns), count: numRows)
        
        /* Create a rectangle for every element in the array*/
        for (i,row) in rectangleArray.enumerated() {
            for (j,_) in row.enumerated() {
                rectangleArray[i][j] = CGRect(x: (1.25*squareSize)*CGFloat(j), y: (1.25*squareSize)*CGFloat(i), width: squareSize, height: squareSize)
                let rounded = UIBezierPath(roundedRect: rectangleArray[i][j], byRoundingCorners: .allCorners, cornerRadii: CGSize(width: squareSize*0.2, height: squareSize*0.2))
                
                /* Set which LEDs are which color based on the topic. */
                switch (topic) {
                case .addition:
                    switch (i*numColumns + j) {
                    case 0..<firstNumber:
                        firstColor.setFill()
                    case firstNumber..<(firstNumber + secondNumber):
                        secondColor.setFill()
                    default:
                        defaultColor.setFill()
                    }
                case .subtraction:
                    let secondNumberCorrected = (secondNumber > firstNumber) ? firstNumber : secondNumber
                    switch (i*numColumns + j) {
                    case 0..<(firstNumber - secondNumberCorrected):
                        firstColor.setFill()
                    case (firstNumber - secondNumberCorrected)..<firstNumber:
                        secondColor.setFill()
                    default:
                        defaultColor.setFill()
                    }
                case .multiplication, .division:
                    if (i < firstNumber) && (j < secondNumber) {
                        firstColor.setFill()
                    } else  {
                        defaultColor.setFill()
                    }
                case .remainder:
                    let secondNumberCorrected = (secondNumber < firstNumber) ? firstNumber : secondNumber
                    if (i < firstNumber) && (j < (secondNumberCorrected / firstNumber)) {
                        firstColor.setFill()
                    } else if (i < (secondNumberCorrected % firstNumber)) && (j < (secondNumberCorrected / firstNumber + 1)) {
                        secondColor.setFill()
                    } else  {
                        defaultColor.setFill()
                    }
                }
                rounded.fill()
            }
        }
        
    }

}
