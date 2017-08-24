//
//  SyntaxTextStorage.swift
//  Tools4ME
//
//  Created by Dr. D.T. on 2017/8/18.
//  Copyright © 2017年 Dr. D.T. All rights reserved.
//

import Cocoa

class SyntaxTextStorage: NSTextStorage {
    
    fileprivate let storage = NSMutableAttributedString()
    
    override var string: String {
        return self.storage.string
    }
    
    override func attributes(at location: Int, effectiveRange: NSRangePointer?) -> [String : Any] {
        return storage.attributes(at: location, effectiveRange: effectiveRange)
    }
    
    override func replaceCharacters(in range: NSRange, with string: String) {
        let beforeLength = length
        storage.replaceCharacters(in: range, with: string)
        edited(.editedCharacters, range: range, changeInLength: length - beforeLength)
    }
    
    override func setAttributes(_ attributes: [String : Any]?, range: NSRange) {
        storage.setAttributes(attributes, range: range)
        edited(.editedAttributes, range: range, changeInLength: 0)
    }
    
    override func processEditing() {
        let text = string as NSString
        print(text)
        setAttributes([
            NSFontAttributeName: NSFont.systemFont(ofSize: 18)
            ], range: NSRange(location: 0, length: length))
        
        text.enumerateSubstrings(in: NSRange(location: 0, length: length), options: .byWords) { [weak self] string, range, _, _ in
            guard let string = string else { return }
            if string.lowercased() == "red" {
                self?.addAttribute(NSForegroundColorAttributeName, value: NSColor.red, range: range)
            } else if string.lowercased() == "bold" {
                self?.addAttribute(NSFontAttributeName, value: NSFont.boldSystemFont(ofSize: 18), range: range)
            }
        }
        
        super.processEditing()
    }

}
