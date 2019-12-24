//
//  AppDelegate.swift
//  word by word
//
//  Created by Kiera O'Flynn on 12/24/19.
//  Copyright © 2019 Knaoinr. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {

    // MARK: - Objects
    
    static var mainWindow: NSWindow?
    let mainWindowController = HomeWindowController()


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        //Start window
        let window = NSWindow(contentRect: NSRect(x: 200, y: 200, width: 800, height: 600), styleMask: [.titled, .closable, .resizable, .miniaturizable], backing: NSWindow.BackingStoreType.buffered, defer: false)
        window.orderFrontRegardless()
        AppDelegate.mainWindow = window
        AppDelegate.mainWindow!.delegate = self
        AppDelegate.mainWindow!.isOpaque = false
        AppDelegate.mainWindow!.windowController = mainWindowController
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

