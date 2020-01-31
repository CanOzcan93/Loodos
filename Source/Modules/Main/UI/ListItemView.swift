//
//  ListItemView.swift
//  HadiMovieSearch
//
//  Created by Can Özcan on 27.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import UIKit
import PromiseKit

extension Main {
    
    public class ListItemView : LDListItemView {
        
        
        private var iv_image: LDImageView!
                
        private var tv_title: LDTextView!
        private var tv_subtitle: LDTextView!
        
        private var isInitialized: Bool = false
        
        public override func onInit() {
            self.item = LDView()
            self.item.isOpaque = false
            self.isUserInteractionEnabled = true
            self.selectionStyle = .none
            
            
            self.item.onDraw = { rect in

                if !self.isInitialized {
                    
                    let path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height*0.2).cgPath
                    let shadowPath = UIBezierPath(roundedRect: rect.inset(by: UIEdgeInsets(top: -0.1, left: -0.1, bottom: -0.1, right: -0.1)), cornerRadius: 8).cgPath

                    let layer = CAShapeLayer()
                    layer.path = path
                    layer.fillColor = self.colorProvider.getWhiteFull().cgColor

                    layer.shadowColor = self.colorProvider.getBlackFull().cgColor
                    layer.shadowPath = shadowPath
                    layer.shadowOffset = .zero
                    layer.shadowOpacity = 0.2
                    layer.shadowRadius = 8

                    self.item.layer.insertSublayer(layer, at: 0)

                    self.isInitialized = true
                }

            }
            
            contentView.addSubview(self.item)
            
        }
        
        public func changeLabels(item: Movie) {
            tv_subtitle.text = "Year: \(item.year) \nType: \(item.type)"
            tv_title.text = item.title
            iv_image.image = item.image
        }
        
        public func addAction(onClick: @escaping Action) {
            
            self.item.onTap {
                onClick()
            }
            
        }
        
        public override func onConstruct(wrapper: UIView, item: LDView) {
            
            super.onConstruct(wrapper: wrapper, item: item)
            wrapper.backgroundColor = colorProvider.getNormalBlue()
            constructImage(item: item)
            constructTitleTextView(item: item)
            constructSubtitleTextView(item: item)

        }
        
        private func constructImage(item: LDView) {
            
            self.iv_image = LDImageView()
            self.iv_image.backgroundColor = colorProvider.getGrayLightest()
            
            item.addSubview(self.iv_image)
            
        }

        private func constructTitleTextView(item: LDView) {

            self.tv_title = LDTextView()
            self.tv_title.textColor = colorProvider.getDarkGray()
            self.tv_title.numberOfLines = 2
            
            item.addSubview(self.tv_title)

        }

        private func constructSubtitleTextView(item: LDView) {
            
            self.tv_subtitle = LDTextView()
            self.tv_subtitle.textColor = colorProvider.getDarkGray()
            self.tv_subtitle.numberOfLines = 2
            
            item.addSubview(self.tv_subtitle)
            
        }


        
        public override func onConstrain(set: inout [NSLayoutConstraint], wrapper: UIView, item: LDView) {
            
            super.onConstrain(set: &set, wrapper: wrapper, item: item)
            
            set.append(NSLayoutConstraint(item: wrapper, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 120))
            
            set.append(NSLayoutConstraint(item: item, attribute: .width, relatedBy: .equal, toItem: wrapper, attribute: .width, multiplier: 1, constant: -10))
            set.append(NSLayoutConstraint(item: item, attribute: .centerX, relatedBy: .equal, toItem: wrapper, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: item, attribute: .top, relatedBy: .equal, toItem: wrapper, attribute: .top, multiplier: 1, constant: 15))
            set.append(NSLayoutConstraint(item: item, attribute: .bottom, relatedBy: .equal, toItem: wrapper, attribute: .bottom, multiplier: 1, constant: -15))
            
            constrainImage(set: &set, wrapper: wrapper, item: item)
            constrainTitleTextView(set: &set, wrapper: wrapper, item: item)
            constrainSubtitleTextView(set: &set, wrapper: wrapper, item: item)
            
        }
        
        private func constrainImage(set: inout [NSLayoutConstraint], wrapper: UIView, item: LDView) {
            
            set.append(NSLayoutConstraint(item: iv_image, attribute: .left, relatedBy: .equal, toItem: item, attribute: .left, multiplier: 1, constant: 7.5))
            set.append(NSLayoutConstraint(item: iv_image, attribute: .top, relatedBy: .equal, toItem: item, attribute: .top, multiplier: 1, constant: 5))
            set.append(NSLayoutConstraint(item: iv_image, attribute: .bottom, relatedBy: .equal, toItem: item, attribute: .bottom, multiplier: 1, constant: -5))
            set.append(NSLayoutConstraint(item: iv_image, attribute: .width, relatedBy: .equal, toItem: iv_image, attribute: .height, multiplier: 1, constant: 0))
            
        }
        
        private func constrainTitleTextView(set: inout [NSLayoutConstraint], wrapper: UIView, item: LDView) {

            set.append(NSLayoutConstraint(item: tv_title, attribute: .top, relatedBy: .equal, toItem: item, attribute: .top, multiplier: 1, constant: 4))
            set.append(NSLayoutConstraint(item: tv_title, attribute: .left, relatedBy: .equal, toItem: iv_image, attribute: .right, multiplier: 1, constant: 5))
            set.append(NSLayoutConstraint(item: tv_title, attribute: .right, relatedBy: .equal, toItem: item, attribute: .right, multiplier: 1, constant: -5))
            set.append(NSLayoutConstraint(item: tv_title, attribute: .height, relatedBy: .equal, toItem: item, attribute: .height, multiplier: 0.5, constant: 0))

        }

        private func constrainSubtitleTextView(set: inout [NSLayoutConstraint], wrapper: UIView, item: LDView) {

            set.append(NSLayoutConstraint(item: tv_subtitle, attribute: .bottom, relatedBy: .equal, toItem: item, attribute: .bottom, multiplier: 1, constant: -4))
            set.append(NSLayoutConstraint(item: tv_subtitle, attribute: .left, relatedBy: .equal, toItem: iv_image, attribute: .right, multiplier: 1, constant: 5))
            set.append(NSLayoutConstraint(item: tv_subtitle, attribute: .right, relatedBy: .equal, toItem: item, attribute: .right, multiplier: 1, constant: -5))
            set.append(NSLayoutConstraint(item: tv_subtitle, attribute: .height, relatedBy: .equal, toItem: item, attribute: .height, multiplier: 0.5, constant: 0))
            

        }
        
        
    }
    
}
