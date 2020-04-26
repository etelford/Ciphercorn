//
//  ViewController.swift
//  CipherSender
//
//  Created by Erik Telford on 5/25/19.
//  Copyright © 2019 Highway 1 Design. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMessageComposeViewControllerDelegate {

    @IBOutlet weak var messageField: UITextView!
    @IBOutlet weak var successMessage: UILabel!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBAction func sendMessage(_ sender: Any) {
        let cipherMap: [String: String] = [
            "A": "B",
            "B": "V",
            "C": "G",
            "D": "Q",
            "E": "K",
            "F": "M",
            "G": "N",
            "H": "A",
            "I": "D",
            "J": "Z",
            "K": "C",
            "L": "W",
            "M": "S",
            "N": "E",
            "O": "O",
            "P": "Y",
            "Q": "F",
            "R": "J",
            "S": "X",
            "T": "H",
            "U": "T",
            "V": "L",
            "W": "P",
            "X": "U",
            "Y": "I",
            "Z": "R",
            "a": "b",
            "b": "v",
            "c": "g",
            "d": "q",
            "e": "k",
            "f": "m",
            "g": "n",
            "h": "a",
            "i": "d",
            "j": "z",
            "k": "c",
            "l": "w",
            "m": "s",
            "n": "e",
            "o": "o",
            "p": "y",
            "q": "f",
            "r": "j",
            "s": "x",
            "t": "h",
            "u": "t",
            "v": "l",
            "w": "p",
            "x": "u",
            "y": "i",
            "z": "r",
        ]
        
        var encodedMessage = ""
        
        for char in messageField.text {
            let str = String(char)
            
            if cipherMap.keys.contains(str) {
                encodedMessage += cipherMap[str]!
            } else {
                encodedMessage += str
            }
        }
        
        if (MFMessageComposeViewController.canSendText()) {
            let composeVC = MFMessageComposeViewController()
            composeVC.messageComposeDelegate = self
            composeVC.body = encodedMessage
        
            self.present(composeVC, animated: true, completion: nil)
        }
        
        print(encodedMessage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        successMessage.alpha = 0
        sendMessageButton.layer.cornerRadius = 10
        
        navigationController?.navigationBar.barStyle = .black
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
            case MessageComposeResult.sent:
                messageField.text = ""
            
                let animationDuration = 0.5
                
                // Fade in/fade out the success label
                UIView.animate(withDuration: animationDuration, delay: 0.5, options: [.curveEaseInOut], animations: { () -> Void in
                    self.successMessage.alpha = 1
                }) { (Bool) -> Void in
                    UIView.animate(withDuration: animationDuration, delay: 5.0, options: [.curveEaseInOut], animations: { () -> Void in
                        self.successMessage.alpha = 0
                    }, completion: nil)
                }
            
            break;
        default:
            break;
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
}

