//
//  MainLayout-Main.swift
//  HadiMovieSearch
//
//  Created by Can Özcan on 27.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import UIKit

extension Main {
    
    public class MainLayout: LDLayout {
        
        public var lv: ListView!
        public var v_background: LDView!
        public var ti: LDTextInput!
        public var popup_alert: WaitingPopup!
        
        private var isInitialized: Bool = false
        
        public override func onConstruct() {
            
            self.backgroundColor = self.colorProvider.getNormalBlue()
            constructListView()
            constructBackgroundView()
            constructTextInput()
            constructPopup()
            
        }
        
        private func constructListView() {
            
            lv = ListView(items: [])
            lv.backgroundColor = self.colorProvider.getNormalBlue()
            self.addSubview(lv)
            
        }
        
        private func constructBackgroundView() {
            
            v_background = LDView()
            self.v_background.onDraw = { rect in
                
                if !self.isInitialized {

                    let path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height*0.2).cgPath
                    let shadowPath = UIBezierPath(roundedRect: rect.inset(by: UIEdgeInsets(top: -0.1, left: -0.1, bottom: -0.1, right: -0.1)), cornerRadius: 8).cgPath

                    let layer = CAShapeLayer()
                    layer.path = path
                    layer.borderColor = self.colorProvider.getDarkGray().cgColor
                    layer.fillColor = self.colorProvider.getWhiteFull().cgColor

                    layer.shadowColor = self.colorProvider.getBlackFull().cgColor
                    layer.shadowPath = shadowPath
                    layer.shadowOffset = .zero
                    layer.shadowOpacity = 0.2
                    layer.shadowRadius = 8

                    self.v_background.layer.insertSublayer(layer, at: 0)

                    self.isInitialized = true
                }
                
            }
            self.addSubview(v_background)
            
        }
        
        private func constructTextInput() {
            
            ti = LDTextInput()
            ti.textColor = colorProvider.getDarkGray()
            ti.setPlaceholder(text: "Search", placeholderColor: UIColor.lightGray)
            ti.onPressReturnInKeyboard = {
                self.endEditing(true)
            }
            self.addSubview(ti)
            
        }
        
        private func constructPopup() {
            
            popup_alert = WaitingPopup(layout: self)
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint]) {
            
            constrainListView(set: &set)
            constrainBackgroundView(set: &set)
            constrainTextInput(set: &set)
            
        }
        
        private func constrainListView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: lv, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: lv, attribute: .top, relatedBy: .equal, toItem: v_background, attribute: .bottom, multiplier: 1, constant: 20))
            set.append(NSLayoutConstraint(item: lv, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: lv, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: -100))
            
        }
        
        private func constrainBackgroundView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: v_background, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_background, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 50))
            set.append(NSLayoutConstraint(item: v_background, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.9, constant: 0))
            set.append(NSLayoutConstraint(item: v_background, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50))
            
        }
        
        private func constrainTextInput(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: ti, attribute: .centerX, relatedBy: .equal, toItem: v_background, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: ti, attribute: .centerY, relatedBy: .equal, toItem: v_background, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: ti, attribute: .width, relatedBy: .equal, toItem: v_background, attribute: .width, multiplier: 0.9, constant: 0))
            set.append(NSLayoutConstraint(item: ti, attribute: .height, relatedBy: .equal, toItem: v_background, attribute: .height, multiplier: 0.9, constant: 0))
            
        }

        
    }
    
    
}
