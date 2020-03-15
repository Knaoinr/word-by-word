//
//  AppDelegate.swift
//  word by word
//
//  Created by Kiera O'Flynn on 12/24/19.
//  Copyright © 2019 Knaoinr. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate, NSMenuItemValidation {
    
    //TODO: lyrics, collections...

    // MARK: - Objects
    
    static var mainWindow: NSWindow?
    static var playWindow: NSWindow?
    static var playWindowController: ViewSongWindowController? //for queue
    static var isPlayingQueue = false
    let mainWindowController = HomeWindowController(windowNibName: "HomeWindowController")
    
    @IBOutlet weak var exportMenuItem: NSMenuItem!
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        //Start window
        AppDelegate.mainWindow = mainWindowController.window
        AppDelegate.mainWindow!.delegate = self
        AppDelegate.mainWindow!.isOpaque = false
        AppDelegate.mainWindow!.orderFrontRegardless()
        
        //menu things
        exportMenuItem.target = self
        
        //Reload from memory
        reloadSavedData()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func windowDidResize(_ notification: Notification) {
        mainWindowController.documentView.setFrameSize(NSSize(width: mainWindowController.scrollView.contentView.bounds.width, height: max(500, mainWindowController.scrollView.contentView.bounds.height - 20)))
        mainWindowController.searchViewController.view.setFrameSize(NSSize(width: AppDelegate.mainWindow!.frame.width - 5, height: AppDelegate.mainWindow!.frame.height - 25))
    }
    
    // MARK: - Menu bar
    
    //File>New
    @IBAction func newSong(_ sender: NSMenuItem) {
        mainWindowController.onAddButtonPress(sender)
    }
    
    //File>Import...
    @IBAction func openFile(_ sender: NSMenuItem) {
        let dialog = NSOpenPanel()
        
        dialog.canChooseDirectories = true
        dialog.canCreateDirectories = true
        dialog.allowsMultipleSelection = true
        dialog.allowedFileTypes = ["txt"]

        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            for url in dialog.urls {
                //decode each file
                do {
                    let jsonString = try String(contentsOf: url)
                    let jsonData = jsonString.data(using: .utf8)!
                    let newSongBank = try JSONDecoder().decode([Song].self, from: jsonData)
                    for song in newSongBank {
                        AppDelegate.songBank.append(song)
                    }
                } catch {
                    print("AppDelegate.openFile: Could not convert to [Song]")
                }
            }
        } else {
            // User clicked on "Cancel"
            return
        }
        
       //reload data
        mainWindowController.searchViewController.onSearch(mainWindowController.searchViewController.searchField)
    }
    
    //File>Export...
    @IBAction func exportAs(_ sender: NSMenuItem) {
        let dialog = NSSavePanel()
        
        dialog.message = "This file will contain all selected songs as an array."
        dialog.allowedFileTypes = ["txt"]
        dialog.allowsOtherFileTypes = false

        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            //find selected songs
            var selectedSongs:[Song] = []
            for path in mainWindowController.searchViewController.collectionView.selectionIndexPaths {
                selectedSongs.append((mainWindowController.searchViewController.collectionView.item(at: path) as! SearchCollectionViewItem).song)
            }
            
            //write to chosen place
            do {
                let jsonData = try JSONEncoder().encode(selectedSongs)
                let jsonString = String(data: jsonData, encoding: .utf8)!
                try jsonString.write(to: dialog.url!, atomically: true, encoding: .utf8)
            } catch {
                print("???")
            }
        } else {
            // User clicked on "Cancel"
            return
        }
    }
    
    func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {

        if menuItem.title == "Export…" {
            return (AppDelegate.mainWindow?.windowController as! HomeWindowController).searchViewController.collectionView.selectionIndexPaths.count > 0
        }
        
        return true
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
                print("AppDelegate.songBank: Could not convert to [Song]")
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
                print("AppDelegate.collectionBank: Could not convert to [SongCollection]")
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

