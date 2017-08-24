//
//  TestView.swift
//  Tools4ME
//
//  Created by Dr. D.T. on 2017/8/20.
//  Copyright © 2017年 Dr. D.T. All rights reserved.
//

import Cocoa

class TestView: NSViewController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textView2: NSTextView = {
            let textStorage = SyntaxTextStorage()
            
            let layoutManager = NSLayoutManager()
            textStorage.addLayoutManager(layoutManager)
            
            let textContainer = NSTextContainer()
            layoutManager.addTextContainer(textContainer)
            
            let view = NSTextView(frame: NSRect(x: 0, y: 0, width: 100, height: 120), textContainer: textContainer)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        self.view.addSubview(textView2)
        

        
     //   textView2.textStorage?.setAttributedString("")
//        
//        NSLayoutConstraint.activate([
//            textView2.topAnchor.constraint(equalTo: view.topAnchor),
//            textView2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            textView2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            textView2.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//            ])
        // Do view setup here.
    }
    
}
