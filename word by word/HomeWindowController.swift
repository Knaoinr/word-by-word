//
//  HomeWindowController.swift
//  word by word
//
//  Created by Kiera O'Flynn on 12/24/19.
//  Copyright © 2019 Knaoinr. All rights reserved.
//

import Cocoa

class HomeWindowController: NSWindowController {
    
    // MARK: - Objects
    
    @IBOutlet weak var scrollView: NSScrollView!
    @IBOutlet weak var documentView: NSView!
    
    @IBOutlet weak var homePlayButton: NSButton!
    
    @IBOutlet weak var homeSearchButton: NSButton!
    @IBOutlet weak var homeBrowseButton: NSButton!
    @IBOutlet weak var homeAddButton: NSButton!
    
    @IBOutlet weak var homeSearchLabel: NSTextField!
    @IBOutlet weak var homeBrowseLabel: NSTextField!
    @IBOutlet weak var homeAddLabel: NSTextField!
    
    @IBOutlet weak var sideBarButton: NSButton!
    
    @IBOutlet weak var sideBarView: ColorView!
    @IBOutlet weak var sideBarCollectionView: NSCollectionView!
    let sideBarDataAndDelegate = SideBarDataAndDelegate()
    
    var searchViewController = SearchViewController(backView: nil)
    
    var viewSongWindowController:ViewSongWindowController?
    
    var addWindowArray = Array<AddWindowController>()
    
    let peach = NSColor(calibratedRed: 1, green: 0.3, blue: 0.3, alpha: 1)
    let translucentGrey = NSColor(calibratedWhite: 0.3, alpha: 0.5)
    
    // MARK: - Protocol

    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        createObjects()
        window!.setFrame(NSRect(x: 370, y: 250, width: 800, height: 600), display: true)
    }
    
    // MARK: - Action response methods
    
    @IBAction func onPlayButtonPress(_ sender: NSButton) {
        //play queue
        onPlayQueue(sender)
    }
    
    @IBAction func onSearchButtonPress(_ sender: NSButton) {
        //create new search view to replace document view
        searchViewController = SearchViewController(backView: documentView)
        scrollView.documentView = searchViewController.view
    }
    
    @IBAction func onBrowseButtonPress(_ sender: NSButton) {
        //TODO: browse
    }
    
    @IBAction func onAddButtonPress(_ sender: NSButton) {
        let addWindowController = AddWindowController(windowNibName: "AddWindowController")
        addWindowArray.append(addWindowController)
        addWindowController.window?.makeKeyAndOrderFront(self)
    }
    
    @IBAction func onSideBarButtonPress(_ sender: NSButton) {
        sideBarButton.isHidden = true
        sideBarView.isHidden = false
    }
    
    @IBAction func onHomeButtonPress(_ sender: NSButton) {
        scrollView.documentView = documentView
    }
    
    // For side bar only
    
    @IBAction func onSideBarExitPress(_ sender: NSButton) {
        sideBarButton.isHidden = false
        sideBarView.isHidden = true
    }
    
    @IBAction func onPlayQueue(_ sender: NSButton) {
        //if no songs in queue
        if sideBarDataAndDelegate.queue.isEmpty {
            //add random song
            if let randomSong = AppDelegate.songBank.randomElement() {
                sideBarDataAndDelegate.queue.append(randomSong)
            } else {
                //no songs to play
                return
            }
        }
        
        //play queue!
        AppDelegate.isPlayingQueue = true
        //open view song window
        viewSongWindowController = ViewSongWindowController(sideBarDataAndDelegate.queue[0])
        sideBarDataAndDelegate.queue.remove(at: 0)
        sideBarCollectionView.reloadData()
        if AppDelegate.playWindow == nil {
            AppDelegate.playWindow = viewSongWindowController!.window
        } else {
            let frame = AppDelegate.playWindow!.frame
            AppDelegate.playWindow!.close()
            AppDelegate.playWindow = viewSongWindowController!.window
            AppDelegate.playWindow!.setFrame(frame, display: true)
        }
        AppDelegate.playWindow!.makeKeyAndOrderFront(self)
    }
    
    @IBAction func onShuffleQueue(_ sender: NSButton) {
        sideBarDataAndDelegate.queue.shuffle()
        sideBarCollectionView.reloadData()
    }
    
    @IBAction func onClearQueue(_ sender: NSButton) {
        sideBarDataAndDelegate.queue = []
        sideBarCollectionView.reloadData()
    }
    
    //selecting outside CV deselects
    override func mouseDown(with event: NSEvent) {
        //do normal stuff
        super.mouseDown(with: event)
        
        sideBarCollectionView.deselectAll(nil)
    }
    
    // MARK: - Homemade functions
    
    // Place all objects & their properties
    func createObjects() {
                
        //Establish theme time
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
                
        if hour >= 21 || hour < 5 { //night
            (self.window?.contentView as! ColorView).changeGradientColor(start: .black, end: .blue)
            homePlayButton.image = NSImage(named: "play_purple")
            homeSearchButton.image = NSImage(named: "search_purple")
            homeBrowseButton.image = NSImage(named: "browse_purple")
            homeAddButton.image = NSImage(named: "add_purple")
            homeSearchLabel.textColor = .black
            homeBrowseLabel.textColor = .black
            homeAddLabel.textColor = .black
            homeSearchLabel.backgroundColor = NSColor(calibratedWhite: 1, alpha: 0.2)
            homeBrowseLabel.backgroundColor = homeSearchLabel.backgroundColor!
            homeAddLabel.backgroundColor = homeSearchLabel.backgroundColor!
        } else if hour >= 9 && hour < 17 { //day
            (self.window?.contentView as! ColorView).changeGradientColor(start: .orange, end: .white)
            homePlayButton.image = NSImage(named: "play_orange")
            homeSearchButton.image = NSImage(named: "search_orange")
            homeBrowseButton.image = NSImage(named: "browse_orange")
            homeAddButton.image = NSImage(named: "add_orange")
            homeSearchLabel.textColor = peach
            homeBrowseLabel.textColor = peach
            homeAddLabel.textColor = peach
            homeSearchLabel.backgroundColor = .clear
            homeBrowseLabel.backgroundColor = homeSearchLabel.backgroundColor!
            homeAddLabel.backgroundColor = homeSearchLabel.backgroundColor!
        } else { //dawn/dusk
            (self.window?.contentView as! ColorView).changeGradientColor(start: .systemIndigo, end: .systemOrange)
            homePlayButton.image = NSImage(named: "play_purple")
            homeSearchButton.image = NSImage(named: "search_purple")
            homeBrowseButton.image = NSImage(named: "browse_purple")
            homeAddButton.image = NSImage(named: "add_purple")
            homeSearchLabel.textColor = .black
            homeBrowseLabel.textColor = .black
            homeAddLabel.textColor = .black
            homeSearchLabel.backgroundColor = .clear
            homeBrowseLabel.backgroundColor = homeSearchLabel.backgroundColor!
            homeAddLabel.backgroundColor = homeSearchLabel.backgroundColor!
        }
        
        //Side bar/queue
        sideBarView.changeGradientColor(start: translucentGrey, end: translucentGrey)
        sideBarCollectionView.backgroundColors = [.clear]
        sideBarCollectionView.dataSource = sideBarDataAndDelegate
        sideBarCollectionView.delegate = sideBarDataAndDelegate
        sideBarCollectionView.registerForDraggedTypes([.customSong])
        
        documentView.setFrameSize(NSSize(width: scrollView.contentView.bounds.width, height: max(500, scrollView.contentView.bounds.height)))
    }
    
}
