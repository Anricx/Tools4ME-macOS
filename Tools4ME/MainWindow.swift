//
//  MainWindow.swift
//  Tools4ME
//
//  Created by Dr. D.T. on 2017/8/13.
//  Copyright © 2017年 Dr. D.T. All rights reserved.
//

import Cocoa

class MainWindow: NSWindow, NSWindowDelegate {

    override init(contentRect: NSRect, styleMask style: NSWindowStyleMask, backing bufferingType: NSBackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: bufferingType, defer: flag)
        
        // Set the opaque value off,remove shadows and fill the window with clear (transparent)
        self.isOpaque = true
        self.backgroundColor = NSColor.clear
        // self.backgroundColor = NSColor.black//.withAlphaComponent(0.88)
        
        // Change the title bar appereance
        self.titleVisibility = .hidden
        self.isMovableByWindowBackground = true
        self.titlebarAppearsTransparent = true
    }
    
    func windowShouldClose(_ sender: Any) -> Bool {
        NSApplication.shared().terminate(self)
        return true
    }
    
}
