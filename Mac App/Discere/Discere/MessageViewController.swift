//
//  MessageViewController.swift
//  Discere
//
//  Created by Rohan Iyer on 6/27/15.
//  Copyright (c) 2015 rohan. All rights reserved.
//


import Cocoa


class MessageViewController: NSViewController {

    @IBOutlet weak var confirmLabel: NSTextField!
 
    @IBOutlet weak var firstField: NSTextField!
    
    @IBOutlet weak var lastField: NSTextField!
    
    @IBOutlet weak var messageField: NSTextField! //actually the field where the class is placed
    
    @IBOutlet weak var submitButton: NSButton!
    
    var ref = Firebase(url: "https://discere.firebaseio.com")
    

  override func viewWillAppear() {
    
    super.viewWillAppear()
    firstField.alphaValue = 1
    firstField.stringValue = ""
    
    lastField.alphaValue = 1
    lastField.stringValue = ""
    
    messageField.alphaValue = 1
    messageField.stringValue = ""
    
    submitButton.alphaValue = 1
    
    firstField.enabled = true
    lastField.enabled = true
    messageField.enabled = true
    submitButton.enabled = true
    
    confirmLabel.alphaValue = 0
  }
}

// MARK: Actions

extension MessageViewController {

    @IBAction func submit(sender: NSButton) {
        
        
        if(firstField.stringValue != "" && messageField.stringValue != ""){
            var nref = ref.childByAutoId()
//            var nameref = nref.childByAppendingPath("name")
//            var classref = nref.childByAppendingPath("class")
            
            var vals = ["name": "\(firstField.stringValue) \(lastField.stringValue)", "class": "\(messageField.stringValue)"]
            nref.setValue(vals)
            
//            classref.setValue("\(messageField.stringValue)")
//            nameref.setValue("\(firstField.stringValue) \(lastField.stringValue)")
//            nref.setV
            
            NSAnimationContext.runAnimationGroup({context in
                    context.duration = 5.0
                    self.firstField.alphaValue = 0
                    self.lastField.alphaValue = 0
                    self.messageField.alphaValue = 0
                    self.submitButton.alphaValue = 0
                }, completionHandler: {
                    self.firstField.enabled = false
                    self.lastField.enabled = false
                    self.messageField.enabled = false
                    self.submitButton.enabled = false
                    NSAnimationContext.runAnimationGroup({context2 in
                            context2.duration = 5.0
                            self.confirmLabel.alphaValue = 1
                        }, completionHandler: {
                            
                    })
            })
        }

    }

  @IBAction func quit(sender: NSButton) {
    NSApplication.sharedApplication().terminate(sender)
  }
}
