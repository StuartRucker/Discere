/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

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
