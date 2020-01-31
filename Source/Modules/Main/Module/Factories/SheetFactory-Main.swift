//
//  SheetFactory-Main.swift
//  HadiMovieSearch
//
//  Created by Can Özcan on 27.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import Foundation

extension Main {
    
    public class SheetFactory: LDSheetFactory {
        
        private var mainSheet: MainSheet?
        public func getMainSheet() -> MainSheet {
            
            guard mainSheet != nil else {
                mainSheet = MainSheet()
                return mainSheet!
            }
            
            return mainSheet!
            
        }
        
        private var splashSheet: SplashSheet?
        public func getSplashSheet() -> SplashSheet {
            
            guard splashSheet != nil else {
                splashSheet = SplashSheet()
                return splashSheet!
            }
            
            return splashSheet!
            
        }
        
        private var detailSheet: DetailSheet?
        public func getDetailSheet() -> DetailSheet {
           
            guard detailSheet != nil else {
                detailSheet = DetailSheet()
                return detailSheet!
            }
           
            return detailSheet!
           
        }
        
        
    }
}
