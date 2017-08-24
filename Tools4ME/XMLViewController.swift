//
//  XMLViewController.swift
//  Tools4ME
//
//  Created by Dr. D.T. on 2017/8/17.
//  Copyright © 2017年 Dr. D.T. All rights reserved.
//

import Cocoa

class XMLViewController: AbstractTabItemViewController {

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
    
    @IBAction func onCompact(_ sender: Any) {
        let text : String = (self.textView.textStorage as NSAttributedString!).string
        if (text.characters.count == 0) {
            self.showHUD(text: NSLocalizedString("message.input.empty", comment: "message.input.empty"))
            return
        }
        
        do {
            let xmlNode = try XMLDocument.init(xmlString: text, options: Int(XMLNode.Options.documentValidate.rawValue)) as XMLNode
            let payload : String = xmlNode.xmlString(withOptions: Int(XMLNode.Options.nodeCompactEmptyElement.rawValue))
            
            // Replace By Pretty String
            self.textView.textStorage?.mutableString.setString(payload)
        } catch {
            let hud : MBProgressHUD = MBProgressHUD.showAdded(to: self.view.window?.contentView, animated: true)
            hud.mode = MBProgressHUDModeText
            hud.labelFont = NSFont.systemFont(ofSize: 14.0)
            hud.labelText = NSLocalizedString("message.input.invalid.xml", comment: "message.input.invalid.xml")
            hud.labelFont = NSFont.systemFont(ofSize: 14)
            // Only Select First Line
            var message = (error.localizedDescription.components(separatedBy: .newlines)[0] as String).trimmingCharacters(in: .whitespacesAndNewlines)
            // Only Select First Description
            let args = message.components(separatedBy: ":")
            message = args.count > 2 ? args[0] + ": " + args[1] : message
            
            hud.detailsLabelText = message
            hud.detailsLabelFont = NSFont.systemFont(ofSize: 12)
            hud.margin = 10.0
            hud.opacity = 0.8
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return
        }
    }
    
    @IBAction func onPretty(_ sender: Any) {
        let text : String = (self.textView.textStorage as NSAttributedString!).string
        if (text.characters.count == 0) {
            self.showHUD(text: NSLocalizedString("message.input.empty", comment: "message.input.empty"))
            return
        }
        
        do {
            let document = try XMLDocument.init(xmlString: text, options: Int(XMLNode.Options.documentValidate.rawValue))
            let xmlNode : XMLNode = document as XMLNode
            let payload : String = xmlNode.xmlString(withOptions: Int(XMLNode.Options.nodePrettyPrint.rawValue))
            
            // Replace By Pretty String
            self.textView.textStorage?.mutableString.setString(payload)
        } catch {
            let hud : MBProgressHUD = MBProgressHUD.showAdded(to: self.view.window?.contentView, animated: true)
            hud.mode = MBProgressHUDModeText
            hud.labelFont = NSFont.systemFont(ofSize: 14.0)
            hud.labelText = NSLocalizedString("message.input.invalid.xml", comment: "message.input.invalid.xml")
            hud.labelFont = NSFont.systemFont(ofSize: 14)
            // Only Select First Line
            var message = (error.localizedDescription.components(separatedBy: .newlines)[0] as String).trimmingCharacters(in: .whitespacesAndNewlines)
            // Only Select First Description
            let args = message.components(separatedBy: ":")
            message = args.count > 2 ? args[0] + ": " + args[1] : message
            
            hud.detailsLabelText = message
            hud.detailsLabelFont = NSFont.systemFont(ofSize: 12)
            hud.margin = 10.0
            hud.opacity = 0.8
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return
        }
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
