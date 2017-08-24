//
//  SyntaxTextView.swift
//  Tools4ME
//
//  Created by Dr. D.T. on 2017/8/20.
//  Copyright © 2017年 Dr. D.T. All rights reserved.
//

import Cocoa

class SyntaxTextView: NSTextView {
    
    public override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        Swift.print("D")
    }
    
    public override init(frame frameRect: NSRect, textContainer container: NSTextContainer?) {
        super.init(frame: frameRect, textContainer: container)
        Swift.print("C")
    }
    
    public required init?(coder: NSCoder) {
        Swift.print("A")
        super.init(coder: coder)
       // super.replaceTextContainer(NSTextContainer)
//        
//        let textStorage = SyntaxTextStorage()
//        
//        let layoutManager = NSLayoutManager()
//        textStorage.addLayoutManager(layoutManager)
//        
//        let textContainer = NSTextContainer()
//        
//        layoutManager.addTextContainer(textContainer)
//        super.init(frame: NSRect(x: 0, y: 0, width: 100, height: 120), textContainer: textContainer)
//        
//        self.drawsBackground = coder
        
    }
    
}
