//
//  LDListView.swift
//  Loodos
//
//  Created by Can Özcan on 27.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import UIKit

open class LDListView<ListItemType: LDListItemView>: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    // Internal Fields
    
    private var set: [NSLayoutConstraint]!
    
    // Virtuals
    
    open func onInit() {}
    open func onInjection() {}
    open func onConstruct() {}
    open func onConstrain() {}
    open func emptyMessage() -> String { return "" }
    open func needSeparator() -> Bool { return false }
    
    public var onDraw: ActionWith<CGRect>!
    public var scrolledBottom: Action!
    
    
    // Required Fields
    
    public var items: [ListItemType]!
    
    
    // init
    
    public init(items: [ListItemType]) {
        
        self.items = items
        
        super.init(frame: .zero, style: .plain)
        
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
        self.rowHeight = UITableView.automaticDimension
        self.register(ListItemType.self, forCellReuseIdentifier: ListItemType.dequeueItemName)
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        
        onInit()
        onInjection()
        onConstruct()
        onConstrain()
        
    }
    public required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    // Update Table View
    
    open func addItems(_ items: [ListItemType]) {
        for item in items {
            self.items.append(item)
        }
        self.reloadData()
    }
    
    open func replaceItems(_ items: [ListItemType]) {
        self.items = items
        self.reloadData()
    }
    
    open func reset() {
        self.items = [ListItemType]()
        
        self.reloadData()
    }
    
    
    // Draw Implementation
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        onDraw?(rect)
    }
    
    
    // TableView Implementation
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.count == 0 {
            self.setEmptyMessage(emptyMessage())
        }
        else {
            self.restore(separatorNeeded: self.needSeparator())
        }
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return items[indexPath.row]
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let height = self.frame.size.height
        let contentYoffset = self.contentOffset.y
        let distanceFromBottom = self.contentSize.height - contentYoffset
        if distanceFromBottom <= height {
            self.scrolledBottom?()
        }
    }
    
    
}
