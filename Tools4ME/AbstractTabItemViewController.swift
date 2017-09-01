//
//  AbstractTabViewController.swift
//  Tools4ME
//
//  Created by Dr. D.T. on 2017/8/17.
//  Copyright © 2017年 Dr. D.T. All rights reserved.
//

import Cocoa

class AbstractTabItemViewController: NSViewController {
    
    let minFontSize : CGFloat = 12.0
    let maxFontSize : CGFloat = 48.0
    
    override func viewDidAppear() {
        super.viewDidAppear()
        let hud : MBProgressHUD = MBProgressHUD.showAdded(to: self.view.window?.contentView, animated: true)
        hud.mode = MBProgressHUDModeText
        hud.labelFont = NSFont.systemFont(ofSize: 16.0)
        hud.labelText = (self.parent as! NSTabViewController).tabView.selectedTabViewItem?.label
        hud.detailsLabelText = NSLocalizedString("message.tabview.hud.switched", comment: "message.tabview.hud.switched")
        // hud.color = NSColor.purple.withAlphaComponent(0.88)
        hud.opacity = 0.8
        hud.margin = 16.0
        hud.removeFromSuperViewOnHide = true
        hud.hide(true, afterDelay: 0.3)
    }
    
    func showHUD(text : String) {
        let hud : MBProgressHUD = MBProgressHUD.showAdded(to: self.view.window?.contentView, animated: true)
        hud.mode = MBProgressHUDModeText
        hud.labelFont = NSFont.systemFont(ofSize: 14.0)
        hud.labelText = text
        hud.opacity = 0.8
        hud.margin = 10.0
        hud.removeFromSuperViewOnHide = true
        hud.hide(true, afterDelay: 0.5)
    }
    
}
