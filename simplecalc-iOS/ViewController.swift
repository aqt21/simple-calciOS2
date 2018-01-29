//
//  ViewController.swift
//  simplecalc-iOS
//
//  Created by Andrew Tran on 1/29/18.
//  Copyright © 2018 Andrew Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var argsLabel: UILabel!
    @IBOutlet weak var decimalButton: UIButton!
    var args : [String] = []
    var numPressed = false
    var countCheck = false
    var averageCheck = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func equalsPress(_ sender: UIButton) {
        if countCheck {
            args.append("count")
            countCheck = false
        } else
        if averageCheck{
            args.append("avg")
            averageCheck = false
        }
        let answer = calculate(args)
        answerLabel.text = String(answer)
        argsLabel.text = ""
        args = []
        numPressed = false
    }
    
    @IBAction func factPress(_ sender: UIButton) {
        args.append("fact")
        let answer = calculate(args)
        answerLabel.text = String(answer)
        argsLabel.text = ""
        args = []
        numPressed = false
    }
    
    @IBAction func buttonPress(_ sender: UIButton) {
        if !numPressed {
            args.append(sender.titleLabel!.text!)
            numPressed = true
            decimalButton.isEnabled = true
        } else {
            if sender.titleLabel!.text! == "." {
                decimalButton.isEnabled = false
            }
            args[args.count - 1] += (sender.titleLabel!.text!)
        }
        argsLabel.text! += "\(sender.titleLabel!.text!)"
    }
    
    @IBAction func oppPress(_ sender: UIButton) {
        args.append(sender.titleLabel!.text!)
        argsLabel.text! += " \(sender.titleLabel!.text!) "
        numPressed = false
    }
    
    @IBAction func clearPress(_ sender: UIButton) {
        args = []
        answerLabel.text! = "0"
        argsLabel.text! = ""
        averageCheck = false
        countCheck = false
        numPressed = false
    }

    @IBAction func extendedOppPress(_ sender: UIButton) {
        let buttonPressed = sender.titleLabel!.text!
        if buttonPressed == "count" {
            argsLabel.text! += " count "
            countCheck = true
        } else
        if buttonPressed == "average" {
            argsLabel.text! += " avg "
            averageCheck = true
        }

        numPressed = false
    }
    
    public func calculate(_ args: [String]) -> Double {
        if args[args.count - 1] == "count" {
            return Double(args.count - 1)
        }
        if args[args.count - 1] == "fact" {
            if args.count == 1 {
                return 0
            }
            else if args[0] == "1" {
                return 1
            }
            else {
                var first : Int? = Int(args[args.count - 2])
                for i in (1 ... first! - 1).reversed() {
                    first = first! * i
                }
                
                return Double(first!)
            }
        }
        if args[args.count - 1] == "avg" {
            if args.count == 1 {
                return 0
            }
            else if args.count == 2 {
                let curr : Double? = Double(args[0])
                return curr!
            }
            else {
                var total = 0.0
                
                for i in 0 ... args.count - 2 {
                    let curr : Double? = Double(args[i])
                    total += curr!
                }
                return total / Double((args.count - 1))
            }
        }
        if args[1] == "+" {
            let first : Double? = Double(args[0])
            let second : Double? = Double(args[2])
            return first! + second!
        }
        if args[1] == "-" {
            let first : Double? = Double(args[0])
            let second : Double? = Double(args[2])
            return first! - second!
        }
        if args[1] == "/" {
            let first : Double? = Double(args[0])
            let second : Double? = Double(args[2])
            return first! / second!
        }
        if args[1] == "*" {
            let first : Double? = Double(args[0])
            let second : Double? = Double(args[2])
            return first! * second!
        }
        if args[1] == "%" {
            var first : Double? = Double(args[0])
            let second : Double? = Double(args[2])
            while first! >= second! {
                first! -= second!
            }
            
            return first!
        }
        
        return 0
    }
}

