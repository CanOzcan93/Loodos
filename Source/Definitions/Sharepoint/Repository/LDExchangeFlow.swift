//
//  LDExchangeFlow.swift
//  Loodos
//
//  Created by Can Özcan on 27.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import UIKit

open class LDExchangeFlow {
    
    public required init() {
        
    }
    
    private var lastSelectedMovie: Movie?
    public func letSelectedMovie(place: Movie?) {
        self.lastSelectedMovie = place
    }
    public func grabLastSelectedMovie() -> Movie? {
        return self.lastSelectedMovie
    }
    
}
