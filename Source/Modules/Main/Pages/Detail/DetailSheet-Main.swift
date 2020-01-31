//
//  DetailSheet-Main.swift
//  HadiMovieSearch
//
//  Created by Can Özcan on 27.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import UIKit
import SwiftyJSON
import PromiseKit
//import AlamofireImage

extension Main {
    
    public class DetailSheet: Sheet<DetailLayout> {
        
        public override func onLayoutReady(layout: DetailLayout) {
            
            layout.btn_back.onClick {
                self.demonstrator.goBack()
            }
            
        }
        
        public override func onLayoutAppear(layout: Main.DetailLayout) {
            
            layout.dataInitilization(movie: self.exchangeFlow.grabLastSelectedMovie()!)
            
        }
        
        
    }
    
}
