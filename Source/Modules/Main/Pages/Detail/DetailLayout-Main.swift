//
//  DetailLayout-Main.swift
//  HadiMovieSearch
//
//  Created by Can Özcan on 27.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import UIKit

extension Main {
    
    public class DetailLayout: LDLayout {
        
        private var iv_poster: LDImageView!
        public var btn_back: LDButton!
        public var sv: UIScrollView!
        private var tv_title: LDTextView!
        private var tv_genre: LDTextView!
        private var tv_rating: LDTextView!
        private var tv_director: LDTextView!
        private var tv_actors: LDTextView!
        private var tv_overview: LDMultilineTextInput!

        
        public override func onConstruct() {
            
            self.backgroundColor = colorProvider.getNormalBlue()
            
            constructScrollView()
            constructPosterImageView()
            constructBackButton()
            constructTitleTextView()
            constructGenreTextView()
            constructRatingTextView()
            constructDirectorTextView()
            constructActorsTextView()
            constructOverviewTextView()
            
        }
        
        private func constructScrollView() {
            
            sv = UIScrollView()
            sv.translatesAutoresizingMaskIntoConstraints = false
            sv.contentSize = CGSize(width: self.frame.width, height: 1000)
            self.addSubview(sv)
            
        }
        
        private func constructBackButton() {
            
            btn_back = LDButton()
            btn_back.setTitle("Back To List", for: .normal)
            btn_back.setTitleColor(self.colorProvider.getNormalBlue(), for: .normal)
            btn_back.clipsToBounds = true
            btn_back.backgroundColor = .white
            btn_back.onDraw = { rect in
                self.btn_back.layer.cornerRadius = self.btn_back.frame.height / 2
            }
            self.addSubview(btn_back)
            
        }
        
        private func constructPosterImageView() {
            
            iv_poster = LDImageView()
            iv_poster.backgroundColor = UIColor.red
            sv.addSubview(iv_poster)
            
        }
        
        
        private func constructTitleTextView() {
            
            tv_title = LDTextView()
            tv_title.text = "Title"
            tv_title.numberOfLines = 2
            tv_title.font = fontProvider.getSemiboldLarge()
            tv_title.textColor = .white
            sv.addSubview(tv_title)
            
        }
        
        private func constructGenreTextView() {
            
            tv_genre = LDTextView()
            tv_genre.text = "Genre"
            tv_genre.font = fontProvider.getLightSmall()
            tv_genre.textColor = .white
            sv.addSubview(tv_genre)
            
        }
        
        private func constructRatingTextView() {
            
            tv_rating = LDTextView()
            tv_rating.text = "Rating: N/A-10"
            tv_rating.font = fontProvider.getLightSmall()
            tv_rating.textColor = .white
            sv.addSubview(tv_rating)
            
        }
        
        private func constructDirectorTextView() {
            
            tv_director = LDTextView()
            tv_director.text = "Director: "
            tv_director.font = fontProvider.getLightSmall()
            tv_director.textColor = .white
            sv.addSubview(tv_director)
            
        }
        
        private func constructActorsTextView() {
            
            tv_actors = LDTextView()
            tv_actors.text = "Actors: "
            tv_actors.numberOfLines = 2
            tv_actors.font = fontProvider.getLightSmall()
            tv_actors.textColor = .white
            sv.addSubview(tv_actors)
            
        }
        
        private func constructOverviewTextView() {
            
            tv_overview = LDMultilineTextInput()
            tv_overview.isUserInteractionEnabled = false
            tv_overview.isScrollEnabled = false
            
            tv_overview.font = fontProvider.getRegularMedium()
            tv_overview.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse ultrices magna nec erat mollis, quis tincidunt orci imperdiet. Maecenas at dapibus neque. Curabitur faucibus orci ligula, a porta nibh dictum id. Fusce ut posuere est. Orci varius natoque penatibus et."
            tv_overview.textColor = .white
            tv_overview.backgroundColor = .clear
            sv.addSubview(tv_overview)
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint]) {
            
            constrainPosterImageView(set: &set)
            constrainScrollView(set: &set)
            constrainBackButton(set: &set)
            constrainTitleTextView(set: &set)
            constrainGenreTextView(set: &set)
            constrainRatingTextView(set: &set)
            constrainDirectorTextView(set: &set)
            constrainActorsTextView(set: &set)
            constrainOverviewTextView(set: &set)
            
        }
        
        private func constrainScrollView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: sv, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: sv, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: sv, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: sv, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
            
        }
        
        private func constrainPosterImageView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: iv_poster, attribute: .centerX, relatedBy: .equal, toItem: sv, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_poster, attribute: .top, relatedBy: .equal, toItem: sv, attribute: .top, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_poster, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_poster, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.4, constant: 0))
        
        }
        
        private func constrainBackButton(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: btn_back, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: btn_back, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -20))
            set.append(NSLayoutConstraint(item: btn_back, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.75, constant: 0))
            set.append(NSLayoutConstraint(item: btn_back, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
            
        }
        
        
        
        private func constrainTitleTextView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: tv_title, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 15))
            set.append(NSLayoutConstraint(item: tv_title, attribute: .top, relatedBy: .equal, toItem: iv_poster, attribute: .bottom, multiplier: 1, constant: 15))
            set.append(NSLayoutConstraint(item: tv_title, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -30))
            set.append(NSLayoutConstraint(item: tv_title, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60))
            
        }
        
        private func constrainGenreTextView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: tv_genre, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 15))
            set.append(NSLayoutConstraint(item: tv_genre, attribute: .top, relatedBy: .equal, toItem: tv_title, attribute: .bottom, multiplier: 1, constant: 5))
            set.append(NSLayoutConstraint(item: tv_genre, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -30))
            set.append(NSLayoutConstraint(item: tv_genre, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20))
            
        }
        
        private func constrainRatingTextView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: tv_rating, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 15))
            set.append(NSLayoutConstraint(item: tv_rating, attribute: .top, relatedBy: .equal, toItem: tv_genre, attribute: .bottom, multiplier: 1, constant: 5))
            set.append(NSLayoutConstraint(item: tv_rating, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -30))
            set.append(NSLayoutConstraint(item: tv_rating, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20))
            
        }
        
        private func constrainDirectorTextView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: tv_director, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 15))
            set.append(NSLayoutConstraint(item: tv_director, attribute: .top, relatedBy: .equal, toItem: tv_rating, attribute: .bottom, multiplier: 1, constant: 5))
            set.append(NSLayoutConstraint(item: tv_director, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -30))
            set.append(NSLayoutConstraint(item: tv_director, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20))
            
        }
        
        private func constrainActorsTextView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: tv_actors, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 15))
            set.append(NSLayoutConstraint(item: tv_actors, attribute: .top, relatedBy: .equal, toItem: tv_director, attribute: .bottom, multiplier: 1, constant: 5))
            set.append(NSLayoutConstraint(item: tv_actors, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -30))
            set.append(NSLayoutConstraint(item: tv_actors, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
            
        }
        
        private func constrainOverviewTextView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: tv_overview, attribute: .centerX, relatedBy: .equal, toItem: sv, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_overview, attribute: .top, relatedBy: .equal, toItem: tv_actors, attribute: .bottom, multiplier: 1, constant: 15))
            set.append(NSLayoutConstraint(item: tv_overview, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -30))
            set.append(NSLayoutConstraint(item: tv_overview, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 100))

            
        }
        
        public func dataInitilization (movie: Movie) {
            
            self.tv_title.text = movie.title
            self.tv_genre.text = movie.genre
            self.iv_poster.image = movie.image
            self.tv_overview.text = movie.plot
            self.tv_rating.text = "Rating: \(movie.imdbRating!)-10"
            self.tv_director.text = "Director: \(movie.director!)"
            self.tv_actors.text = "Actor: \(movie.actors!)"
            self.tv_overview.sizeToFit()
            
            self.sv.contentSize = CGSize(width: self.frame.width, height: self.tv_overview.frame.maxY + 45)
            
            print(movie)
            
        }
        
        
    
    }
}
