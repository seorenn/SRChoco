//
//  InputSourceController.swift
//  SRChoco
//
//  Created by Seorenn.
//  Copyright (c) 2014 Seorenn. All rights reserved.
//

import Cocoa

class InputSourceController: NSObject, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var tableView: NSTableView!
    
    let ism: SRInputSourceManager
    
    override init() {
        self.ism = SRInputSourceManager.sharedManager()
        super.init()
        
        // TODO: This is test code
        println("Input Sources =====")
        for ism in self.ism.inputSources {
            println(ism)
        }
        println("End of Input Sources =====")
    }
    
    override func awakeFromNib() {
        let currentISIndex = self.ism.currentInputSourceIndex
        self.tableView.selectRowIndexes(NSIndexSet(index: currentISIndex), byExtendingSelection: false)
    }
    
    func numberOfRowsInTableView(tableView: NSTableView!) -> Int {
        return self.ism.inputSources.count
    }
    
    func tableView(tableView: NSTableView!, objectValueForTableColumn tableColumn: NSTableColumn!, row: Int) -> AnyObject! {
        let inputSources = self.ism.inputSources as [SRInputSource]
        return inputSources[row].localizedName
    }
    
    func tableViewSelectionDidChange(notification: NSNotification!) {
        let index = self.tableView.selectedRow
        let inputSources = self.ism.inputSources as [SRInputSource]
        let selectedIS = inputSources[index]
        selectedIS.activate()
    }
}
