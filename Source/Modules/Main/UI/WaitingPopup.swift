//
//  WaitingPopup.swift
//  Loodos
//
//  Created by Can Özcan on 30.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import UIKit

extension Main {

    public class WaitingPopup : LDCompoundView {
        
        
        // Packed Views
        
        private var v_shade: LDView!
        
        private var av_main: LDActivityView!
        
        private var v_background: LDView!
        private var tv: LDTextView!
        private var btn_ok: LDTextView!
    
        
        // Internal Fields
        
        private var hiddenShadeConstraint: NSLayoutConstraint!
        private var visibleShadeConstraint: NSLayoutConstraint!
        private var hiddenAlertConstraint: NSLayoutConstraint!
        private var visibleAlertConstraint: NSLayoutConstraint!
        
        
        // Implementation
        
        open override func onConstruct(layout: LDLayout) {
            
            constructShadeView()
            constructMainActivityView()
            
            constructBackgroundView()
            
            constructTextView()
            constructOKButton()
            
        }
        
        open override func onConstrain(set: inout [NSLayoutConstraint], layout: LDLayout) {
            
            constrainShadeView(set: &set, layout: layout)
            constrainMainActivityView(set: &set)
            
            constrainBackgroundView(set: &set, layout: layout)

            constrainTextView(set: &set)
            constrainOKButton(set: &set)
            
        }
        
        
        // Internal Methods
        
        private func constructShadeView() {
            
            self.v_shade = LDView()
            self.v_shade.backgroundColor = colorProvider.getBlackSoft()
            
            self.packView(self.v_shade)
            
        }
        
        private func constructBackgroundView() {
            
            self.v_background = LDView()
            self.v_background.backgroundColor = colorProvider.getWhiteFull()
            self.v_background.onDraw = { rect in
                
                self.v_background.layer.masksToBounds = true
                self.v_background.layer.cornerRadius = 6
                
            }
            
            self.packView(self.v_background)
            
        }
        
        private func constructMainActivityView() {
            
            self.av_main = LDActivityView()
            self.av_main.startAnimating()
            
            self.packView(self.av_main)
            
        }
        
        private func constructTextView() {

            self.tv = LDTextView()
            self.tv.numberOfLines = 0
            self.tv.font = fontProvider.getRegularMedium()
            self.tv.textColor = colorProvider.getDarkGray()
            self.tv.textAlignment = .center
            self.tv.text = "Nothing Found :("

            self.packView(self.tv)

        }

        private func constructOKButton() {

            self.btn_ok = LDTextView()
            self.btn_ok.text = "OK"
            self.btn_ok.textColor = colorProvider.getRouteBlue()
            self.btn_ok.textAlignment = .center
            self.btn_ok.onTap {
                self.hideAlert()
                self.hide()
            }

            self.packView(self.btn_ok)

        }
        
        private func constrainShadeView(set: inout [NSLayoutConstraint], layout: LDLayout) {
            
            self.hiddenShadeConstraint = NSLayoutConstraint(item: v_shade, attribute: .right, relatedBy: .equal, toItem: layout, attribute: .left, multiplier: 1, constant: 0)
            self.visibleShadeConstraint = NSLayoutConstraint(item: v_shade, attribute: .centerX, relatedBy: .equal, toItem: layout, attribute: .centerX, multiplier: 1, constant: 0)
            
            set.append(hiddenShadeConstraint)
            set.append(NSLayoutConstraint(item: v_shade, attribute: .centerY, relatedBy: .equal, toItem: layout, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_shade, attribute: .width, relatedBy: .equal, toItem: layout, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_shade, attribute: .height, relatedBy: .equal, toItem: layout, attribute: .height, multiplier: 1, constant: 0))
            
        }
        
        private func constrainBackgroundView(set: inout [NSLayoutConstraint], layout: LDLayout) {
            
            self.hiddenAlertConstraint = NSLayoutConstraint(item: v_background, attribute: .right, relatedBy: .equal, toItem: v_shade, attribute: .left, multiplier: 1, constant: 0)
            self.visibleAlertConstraint = NSLayoutConstraint(item: v_background, attribute: .centerX, relatedBy: .equal, toItem: v_shade, attribute: .centerX, multiplier: 1, constant: 0)
            
            set.append(hiddenAlertConstraint)
            set.append(NSLayoutConstraint(item: v_background, attribute: .centerY, relatedBy: .equal, toItem: v_shade, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_background, attribute: .width, relatedBy: .equal, toItem: layout, attribute: .width, multiplier: 1, constant: -45))
            set.append(NSLayoutConstraint(item: v_background, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 155))
            
        }
        
        private func constrainMainActivityView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: av_main, attribute: .centerX, relatedBy: .equal, toItem: v_shade, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: av_main, attribute: .centerY, relatedBy: .equal, toItem: v_shade, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: av_main, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50))
            set.append(NSLayoutConstraint(item: av_main, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50))
            
        }
        
        private func constrainTextView(set: inout [NSLayoutConstraint]) {

            set.append(NSLayoutConstraint(item: tv, attribute: .bottom, relatedBy: .equal, toItem: v_background, attribute: .centerY, multiplier: 1, constant: 10))
            set.append(NSLayoutConstraint(item: tv, attribute: .centerX, relatedBy: .equal, toItem: v_background, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 270))
            set.append(NSLayoutConstraint(item: tv, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80))

        }

        private func constrainOKButton(set: inout [NSLayoutConstraint]) {

            set.append(NSLayoutConstraint(item: btn_ok, attribute: .bottom, relatedBy: .equal, toItem: v_background, attribute: .bottom, multiplier: 1, constant: -20))
            set.append(NSLayoutConstraint(item: btn_ok, attribute: .centerX, relatedBy: .equal, toItem: v_background, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: btn_ok, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 120))
            set.append(NSLayoutConstraint(item: btn_ok, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))

        }
        
        // Methods
        
        public func show() {
            
            self.shift(from: hiddenShadeConstraint, to: visibleShadeConstraint)
            
            self.relayout()
            
        }
        
        public func showAlert() {
            
            self.shift(from: hiddenAlertConstraint, to: visibleAlertConstraint)
            
            self.relayout()
            
        }
        
        
        public func hide() {
            
            self.shift(from: visibleShadeConstraint, to: hiddenShadeConstraint)
            self.relayout()
            
        }

        public func hideAlert() {
            
            self.shift(from: visibleAlertConstraint, to: hiddenAlertConstraint)
            self.relayout()
            
        }
        
        public func changeAlertTitle(str:String?) {
            
            self.tv.text = str
            
        }
        
    }

}

