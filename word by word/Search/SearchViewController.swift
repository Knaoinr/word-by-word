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
        
        view.setFrameSize(NSSize(width: AppDelegate.mainWindow!.frame.width, height: AppDelegate.mainWindow!.frame.height - 20))
        
        collectionView.backgroundColors = [.clear]

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
        } else if highlightState == .none {
            //unhighlight
            for path in indexPaths {
                //set cell to regular
                if !collectionView.item(at: path)!.isSelected {
                    (collectionView.item(at: path) as! SearchCollectionViewItem).setupWithSong(dataSource.searchResults[path.item])
                }
            }
        }
    }
    
    //holding command key allows multiple select
    func collectionView(_ collectionView: NSCollectionView, shouldDeselectItemsAt indexPaths: Set<IndexPath>) -> Set<IndexPath> {
        if NSEvent.modifierFlags.contains(.command) {
            //TODO: change this so if something is already selected it's deselected
            return []
        }
        //don't do the shift thing bc i dont like it
        return indexPaths
    }
    
    //TODO: cmd + A selects all
    //TODO: deselect by pressing on it
    
    
    // MARK: - Methods
    
    @IBAction func onSearch(_ sender: NSSearchField) {
        dataSource.changeSearch(sender.stringValue)
        collectionView.reloadData()
    }
    
}
