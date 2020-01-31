//
//  ListView.swift
//  HadiMovieSearch
//
//  Created by Can Özcan on 27.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import Foundation

extension Main {
    
    public class ListView: LDListView<ListItemView> {
        
        public override func onInit() {
            self.backgroundColor = .clear
        }
        
        public override func emptyMessage() -> String {
            return "Waiting For Searching Input"
        }
        
    }
    
}
