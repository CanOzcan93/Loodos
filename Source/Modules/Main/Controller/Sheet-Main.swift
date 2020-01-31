//
//  Sheet-Main.swift
//  HadiMovieSearch
//
//  Created by Can Özcan on 27.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import Foundation

extension Main {
    
    public class Sheet<LayoutType: LDLayout>: LDSheet<LayoutType> {
        
        private var module: Module!

        open var demonstrator: Demonstrator!

        open override func onInjection() {

            super.onInjection()

            module = Module.getInstance()

            demonstrator = module.demonstrator

        }

        open override func viewDidAppear(_ animated: Bool) {

            super.viewDidAppear(animated)

            demonstrator.setCurrent(vc: self)

        }
    }
}
