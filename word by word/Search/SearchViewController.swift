//
//  SearchViewController.swift
//  word by word
//
//  Created by Kiera O'Flynn on 12/27/19.
//  Copyright © 2019 Knaoinr. All rights reserved.
//

import Cocoa

class SearchViewController: NSViewController, NSCollectionViewDelegate {
    
    // MARK: - Objects
    
    var backView:NSView?
    
    @IBOutlet weak var searchField: NSSearchField!
    @IBOutlet weak var searchFieldCell: NSSearchFieldCell! // TODO: make bigger icons
    @IBOutlet weak var collectionView: NSCollectionView!
    let dataSource = SearchDataSource()
    
    
    // MARK: - Initialization
    
    init(backView: NSView?) {
        super.init(nibName: "SearchViewController", bundle: Bundle.main)
        
        self.backView = backView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        view.setFrameSize(NSSize(width: AppDelegate.mainWindow!.frame.width - 5, height: AppDelegate.mainWindow!.frame.height - 25))

        collectionView.backgroundColors = [.clear]

        //put data in
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        
        dataSource.changeSearch("")
        collectionView.reloadData()
    }
    
    
    // MARK: - Protocol
    
    func collectionView(_ collectionView: NSCollectionView, didChangeItemsAt indexPaths: Set<IndexPath>, to highlightState: NSCollectionViewItem.HighlightState) {
        if highlightState == .forSelection {
            //highlight
            for path in indexPaths {
                //set cell to highlighted
                ((collectionView.item(at: path) as! SearchCollectionViewItem).view as! ColorView).changeGradientColor(start: .systemBlue, end: .systemBlue)
            }
        } else if highlightState == .none || highlightState == .forDeselection {
            //unhighlight
            for path in indexPaths {
                //set cell to regular
                if !collectionView.item(at: path)!.isSelected {
                    (collectionView.item(at: path) as! SearchCollectionViewItem).setupWithSong()
                }
            }
        }
    }
    
    //holding command key allows multiple select
    func collectionView(_ collectionView: NSCollectionView, shouldDeselectItemsAt indexPaths: Set<IndexPath>) -> Set<IndexPath> {
        //cmd key
        if NSEvent.modifierFlags.contains(.command) {
            //if something is already selected it's deselected; else, do not deselect
            var pathsToReturn:Set<IndexPath> = []
            for path in indexPaths {
                if collectionView.item(at: path)!.isSelected {
                    pathsToReturn.insert(path)
                }
            }
            return pathsToReturn
        }
        //don't do the shift thing bc i dont like it

        //else just deselect everything offered
        return indexPaths
    }
    
    //change highlight state on programmatic de/selection as well as regular
    func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
        collectionView.delegate!.collectionView?(collectionView, didChangeItemsAt: indexPaths, to: .forDeselection)
    }
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        collectionView.delegate!.collectionView?(collectionView, didChangeItemsAt: indexPaths, to: .forSelection)
    }
    
    //selecting outside CV deselects
    override func mouseDown(with event: NSEvent) {
        //do normal stuff
        super.mouseDown(with: event)
        
        //if not cmd key
        if !NSEvent.modifierFlags.contains(.command) {
            collectionView.deselectAll(nil)
        }
        
        AppDelegate.mainWindow!.makeFirstResponder(nil)
    }
    
    //drag out
    func collectionView(_ collectionView: NSCollectionView, pasteboardWriterForItemAt indexPath: IndexPath) -> NSPasteboardWriting? {
        return dataSource.searchResults[indexPath.item]
    }
    
    
    // MARK: - Methods
    
    @IBAction func onSearch(_ sender: NSSearchField) {
        dataSource.changeSearch(sender.stringValue)
        collectionView.reloadData()
    }
    
}
