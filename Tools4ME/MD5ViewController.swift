//
//  MD5ViewController.swift
//  Tools4ME
//
//  Created by Dr. D.T. on 2017/8/19.
//  Copyright © 2017年 Dr. D.T. All rights reserved.
//

import Cocoa

class MD5ViewController: AbstractTabItemViewController, NSTextViewDelegate {

    @IBOutlet var textView: NSTextView!
    @IBOutlet weak var textFieldFor32Hex: NSTextField!
    @IBOutlet weak var textFieldFor16Hex: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textView.delegate = self
        self.textView.textColor = NSColor.white
    }
    
    func textDidChange(_ notification: Notification) {
        let text : String = (self.textView.textStorage as NSAttributedString!).string
        if text.characters.count == 0 {
            self.textFieldFor32Hex.stringValue = ""
            self.textFieldFor16Hex.stringValue = ""
        } else {
            let hash32Hex = self.calcMD5Hash(text: text).map { String(format: "%02hhx", $0) }.joined()
            
            self.textFieldFor32Hex.stringValue = hash32Hex
            
            let start = hash32Hex.index(hash32Hex.startIndex, offsetBy: 8)
            let end = hash32Hex.index(hash32Hex.endIndex, offsetBy: -8)
            let range = start..<end

            self.textFieldFor16Hex.stringValue = hash32Hex.substring(with: range)
        }
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
    
    private func calcMD5Hash(text : String) -> Data {
        let messageData = text.data(using: .utf8)
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData?.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG((messageData?.count)!), digestBytes)
            }
        }
        return digestData
    }
    
    @IBAction func onCopy32Hex(_ sender: Any) {
        let text : String = (self.textView.textStorage as NSAttributedString!).string
        if (text.characters.count == 0) {
            self.showHUD(text: NSLocalizedString("message.input.empty", comment: "message.input.empty"))
            return
        }
        
        let pasteboard = NSPasteboard.general()
        pasteboard.declareTypes([NSPasteboardTypeString], owner: nil)
        pasteboard.setString(self.textFieldFor32Hex.stringValue, forType: NSPasteboardTypeString)
        self.showHUD(text: NSLocalizedString("message.action.copied", comment: "message.action.copied"))

    }
    
    @IBAction func onCopy16Hex(_ sender: Any) {
        let text : String = (self.textView.textStorage as NSAttributedString!).string
        if (text.characters.count == 0) {
            self.showHUD(text: NSLocalizedString("message.input.empty", comment: "message.input.empty"))
            return
        }
        
        
        let pasteboard = NSPasteboard.general()
        pasteboard.declareTypes([NSPasteboardTypeString], owner: nil)
        pasteboard.setString(self.textFieldFor16Hex.stringValue, forType: NSPasteboardTypeString)
        self.showHUD(text: NSLocalizedString("message.action.copied", comment: "message.action.copied"))
    }
}
