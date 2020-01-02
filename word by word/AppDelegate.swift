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
    
    //TODO: shortcuts & tool tips...

    // MARK: - Objects
    
    static var mainWindow: NSWindow?
    static var playWindow: NSWindow?
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
        mainWindowController.documentView.setFrameSize(NSSize(width: mainWindowController.scrollView.contentView.bounds.width, height: max(500, mainWindowController.scrollView.contentView.bounds.height - 20)))
        mainWindowController.searchViewController.view.setFrameSize(AppDelegate.mainWindow!.frame.size)
        mainWindowController.sideBarController.reposition(size: AppDelegate.mainWindow!.frame.size)
    }
    
    // MARK: - Data

    func reloadSavedData() {

        // Song bank
        let songBank:[Song] = []
        do {
            let jsonData = try JSONEncoder().encode(songBank)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            let defaultSongBank = ["songBank" : jsonString]
            UserDefaults.standard.register(defaults: defaultSongBank)
        } catch {
            print("AppDelegate.reloadSavedData(): Failed to encode songBank")
        }
        
        // Collections
        let collectionBank:[SongCollection] = []
        do {
            let jsonData = try JSONEncoder().encode(collectionBank)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            let defaultCollectionBank = ["collectionBank" : jsonString]
            UserDefaults.standard.register(defaults: defaultCollectionBank)
        } catch {
            print("AppDelegate.reloadSavedData(): Failed to encode collectionBank")
        }

    }
    
    //Get/set
    
    static var songBank: [Song] {
        get {
            var songBank:[Song] = []
            do {
                let jsonString = UserDefaults.standard.object(forKey: "songBank") as! String
                let jsonData = jsonString.data(using: .utf8)!
                songBank = try JSONDecoder().decode([Song].self, from: jsonData)
            } catch {
                print("AppDelegate.songBank: Could not convert to Song")
            }
            return songBank
        }
        set (bank) {
            do {
                let jsonData = try JSONEncoder().encode(bank)
                let jsonString = String(data: jsonData, encoding: .utf8)!
                UserDefaults.standard.set(jsonString, forKey: "songBank")
            } catch {
                print("AppDelegate.songBank: Failed to encode data")
            }
        }
    }
    
    static var collectionBank: [SongCollection] {
        get {
            var collectionBank:[SongCollection] = []
            do {
                let jsonString = UserDefaults.standard.object(forKey: "collectionBank") as! String
                let jsonData = jsonString.data(using: .utf8)!
                collectionBank = try JSONDecoder().decode([SongCollection].self, from: jsonData)
            } catch {
                print("AppDelegate.collectionBank: Could not convert to SongCollection")
            }
            return collectionBank
        }
        set (bank) {
            do {
                let jsonData = try JSONEncoder().encode(bank)
                let jsonString = String(data: jsonData, encoding: .utf8)!
                UserDefaults.standard.set(jsonString, forKey: "collectionBank")
            } catch {
                print("AppDelegate.collectionBank: Failed to encode data")
            }
        }
    }

}

