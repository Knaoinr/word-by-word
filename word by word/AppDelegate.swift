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
    let mainWindowController = HomeWindowController(windowNibName: "HomeWindowController")


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        //Start window
        AppDelegate.mainWindow = mainWindowController.window
        AppDelegate.mainWindow!.delegate = self
        AppDelegate.mainWindow!.isOpaque = false
        AppDelegate.mainWindow!.orderFrontRegardless()
        
        //Reload from memory
        reloadSavedData()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func windowDidResize(_ notification: Notification) {
        mainWindowController.documentView.setFrameSize(NSSize(width: mainWindowController.scrollView.contentView.bounds.width, height: max(500, mainWindowController.scrollView.contentView.bounds.height)))
        mainWindowController.sideBarController.reposition(size: AppDelegate.mainWindow!.frame.size)
    }

    func reloadSavedData() {

        // Song bank
        let songBank:[Song] = []
        let defaultSongBank = ["songBank" : songBank]
        UserDefaults.standard.register(defaults: defaultSongBank)
        
        // Collections
        let collectionBank:[SongCollection] = []
        let defaultCollectionBank = ["collectionBank" : collectionBank]
        UserDefaults.standard.register(defaults: defaultCollectionBank)

    }

}

