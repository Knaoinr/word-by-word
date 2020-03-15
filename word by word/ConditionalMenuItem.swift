//
//  ConditionalMenuItem.swift
//  word by word
//
//  Created by Kiera O'Flynn on 3/14/20.
//  Copyright © 2020 Knaoinr. All rights reserved.
//

import Cocoa

class ConditionalMenuItem: NSMenuItem, NSMenuItemValidation {
    
    func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        print("validating " + menuItem.title)
        
        if menuItem.title == "Export..." {
            return (AppDelegate.mainWindow?.windowController as! HomeWindowController).searchViewController.collectionView.selectionIndexPaths.count > 0
        }
        
        return false;
    }

}
