//
//  SplashLayout-Main.swift
//  Loodos
//
//  Created by Can Özcan on 28.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import UIKit

extension Main {
    
    public class SplashLayout: LDLayout {
        
        private var v_circle: LDView!
        public var tv_title: LDTextView!
        public var popup_alert: WaitingPopup!
        
        private var displayLink: CADisplayLink!
        
        private var count = 0
        public var loaded = false
        public var afterAnimation: Action!
        
        // MARK: For circle
        private var normalCircleConstraintH: NSLayoutConstraint!
        private var normalCircleConstraintW: NSLayoutConstraint!
        private var biggerCircleConstraintH: NSLayoutConstraint!
        private var biggerCircleConstraintW: NSLayoutConstraint!
        
        // MARK: For Title
        private var hiddenTitleConstraint: NSLayoutConstraint!
        private var appearTitleConstraint: NSLayoutConstraint!

        
        public override func onConstruct() {
            
            constructCircleView()
            constructTitleTextView()
            constructAlertPopup()
            
        }
        
        private func constructCircleView() {
            
            v_circle = LDView()
            v_circle.onDraw = { rect in
                
                if !self.loaded { self.v_circle.layer.cornerRadius = rect.height/2 }
                
            }
            v_circle.backgroundColor = colorProvider.getNormalBlue()
            v_circle.clipsToBounds = true
            self.addSubview(v_circle)
            
        }
        
        private func constructTitleTextView() {
            
            tv_title = LDTextView()
            tv_title.text = "Loodos"
            tv_title.textColor = colorProvider.getWhiteFull()
            tv_title.font = fontProvider.getSemiboldForTitle()
            self.addSubview(tv_title)
            
        }
        
        private func constructAlertPopup() {
            
            popup_alert = WaitingPopup(layout: self)
            popup_alert.showAlert()
            popup_alert.changeAlertTitle(str: "No Internet Connection. \nPlease Try Again Later!")
            
        }
        
        
        public override func onConstrain(set: inout [NSLayoutConstraint]) {
            
            constrainCircleView(set: &set)
            constrainTitleTextView(set: &set)
            
        }
        
       
        
        private func constrainCircleView(set: inout [NSLayoutConstraint]) {
            
            normalCircleConstraintW = NSLayoutConstraint(item: v_circle, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.5, constant: 0)
            normalCircleConstraintH = NSLayoutConstraint(item: v_circle, attribute: .height, relatedBy: .equal, toItem: v_circle, attribute: .width, multiplier: 1, constant: 0)
            
            biggerCircleConstraintW = NSLayoutConstraint(item: v_circle, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0)
            biggerCircleConstraintH = NSLayoutConstraint(item: v_circle, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0)
            
            set.append(NSLayoutConstraint(item: v_circle, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_circle, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(normalCircleConstraintW)
            set.append(normalCircleConstraintH)
            
        }
        
        private func constrainTitleTextView(set: inout [NSLayoutConstraint]) {
            
            hiddenTitleConstraint = NSLayoutConstraint(item: tv_title, attribute: .left, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
            appearTitleConstraint = NSLayoutConstraint(item: tv_title, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
                      
            set.append(hiddenTitleConstraint)
            set.append(NSLayoutConstraint(item: tv_title, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_title, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_title, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 150))
            
           
       }
        
        
        
        
        public override func afterConstrain() {
                        
            displayLink = CADisplayLink(target: self, selector: #selector(animation))
            displayLink.add(to: RunLoop.main, forMode: .default)

            
            let shapeLayer = CAShapeLayer()
            shapeLayer.fillColor = UIColor.white.cgColor
            self.v_circle.layer.insertSublayer(shapeLayer, at: 0)
            
            
        }
        
        @objc private func animation() {
            let totalRadius = self.v_circle.frame.width * 0.5
            count = count % 720
            if count == 0 && self.loaded {
                piePath(startAngle: 270, endAngle: 270,radius: totalRadius)
                self.shift(from: self.normalCircleConstraintW, to: self.biggerCircleConstraintW)
                self.shift(from: self.normalCircleConstraintH, to: self.biggerCircleConstraintH)
                UIView.animate(withDuration: .zero + 1, delay: .zero, options: .curveEaseIn, animations: {
                    self.relayout()
                    self.v_circle.layer.cornerRadius = 0
                }) { state in
                    self.shift(from: self.hiddenTitleConstraint, to: self.appearTitleConstraint)
                    UIView.animate(withDuration: .zero + 1, delay: .zero, options: .curveEaseIn, animations: {
                        self.tv_title.textAlignment = .center
                        self.relayout()
                    }) { state in
                        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                            self.afterAnimation?()
                        }
                        
                    }
                }
                displayLink.remove(from: RunLoop.main, forMode: .default)
            } else if count >= 360 {
                piePath(startAngle: (count % 360) - 87, endAngle: 270,radius: totalRadius * (2-CGFloat(count) / 360.0) )
            }
            else {
                piePath(startAngle: 270, endAngle: (count % 360) - 90,radius: totalRadius * CGFloat(count) / 360.0 )
            }
            count += 4
            
        }
        
        private func piePath(startAngle:Int, endAngle: Int, radius: CGFloat) {
            
            let path = UIBezierPath()
            path.addArc(withCenter: CGPoint(x: self.v_circle.frame.width/2, y: self.v_circle.frame.height/2), radius: radius, startAngle: CGFloat(Double(startAngle) * Double.pi / 180), endAngle: CGFloat(Double(endAngle) * Double.pi / 180), clockwise: true)
            path.addLine(to: CGPoint(x: self.v_circle.frame.width/2, y: self.v_circle.frame.height/2))
            path.close()
            
            (self.v_circle.layer.sublayers?.first! as! CAShapeLayer).path = path.cgPath
            
        }
    
    }
}
