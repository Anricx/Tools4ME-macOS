//
//  Base64ViewController.swift
//  Tools4ME
//
//  Created by Dr. D.T. on 2017/8/13.
//  Copyright © 2017年 Dr. D.T. All rights reserved.
//

import Cocoa

class Base64ViewController: AbstractTabItemViewController {
    
    @IBOutlet weak var textView: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textView.textColor = NSColor.white
        
    }
    
    override func magnify(with event: NSEvent) {
        super.magnify(with: event)
        // Change Size By Zoom
        var fontSize : CGFloat = (self.textView.font?.pointSize)!
        if event.phase == .changed {
            fontSize = fontSize * (1 + event.magnification)
        }
        // Fix to Valid Size...
        if fontSize < self.minFontSize {
            fontSize = self.minFontSize
        } else if fontSize > self.maxFontSize {
            fontSize = self.maxFontSize
        }
        if fontSize == self.textView.font?.pointSize {
            return
        }
        self.textView.font = NSFont.systemFont(ofSize: fontSize)
    }
    
    @IBAction func onEncoding(_ sender: Any) {
        guard let text = self.textView.textStorage?.string, text.count > 0 else {
            self.showHUD(text: NSLocalizedString("message.input.empty", comment: "message.input.empty"))
            return
        }
                
        let payload : String = text.data(using: String.Encoding.utf8)!.base64EncodedString()

        // Replace By Encoded String...
        self.textView.textStorage?.mutableString.setString(payload)
    }
    
    @IBAction func onDecoding(_ sender: Any) {
        let text : String = (self.textView.textStorage as NSAttributedString!).string
        if (text.characters.count == 0) {
            self.showHUD(text: NSLocalizedString("message.input.empty", comment: "message.input.empty"))
            return
        }
        
        // Check is Base64
        let data = Data(base64Encoded: text);
        if (data == nil) {
            self.showHUD(text: NSLocalizedString("message.input.not.base64", comment: "message.input.not.base64"))
            return
        }

        let payload : String = String(data: data!, encoding: .utf8)!
        
        // Replace By Encoded String...
        self.textView.textStorage?.mutableString.setString(payload)
    }
    
    @IBAction func onReset(_ sender: Any) {
        self.textView.textStorage?.mutableString.setString("")
        self.showHUD(text: NSLocalizedString("message.action.cleared", comment: "message.action.cleared"))
    }
    
    @IBAction func onCopy(_ sender: Any) {
        let text : String = (self.textView.textStorage as NSAttributedString!).string
        if (text.characters.count == 0) {
            self.showHUD(text: NSLocalizedString("message.action.copy.empty", comment: "message.action.copy.empty"))
            return
        }
        
        let pasteboard = NSPasteboard.general()
        pasteboard.declareTypes([NSPasteboardTypeString], owner: nil)
        pasteboard.setString(text, forType: NSPasteboardTypeString)
        self.showHUD(text: NSLocalizedString("message.action.copied", comment: "message.action.copied"))
    }
}
