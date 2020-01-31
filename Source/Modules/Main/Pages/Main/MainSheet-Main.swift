//
//  MainSheet-Main.swift
//  HadiMovieSearch
//
//  Created by Can Özcan on 27.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import UIKit
import SwiftyJSON
import PromiseKit
import Firebase

extension Main {
    
    public class MainSheet: Sheet<MainLayout> {
                
        public override func onLayoutReady(layout: MainLayout) {
            
            var items = [ListItemView]()
            
            layout.lv.scrolledBottom = {
                
                layout.popup_alert.show()
                
                self.apiManager.nextList().then { (movieArray) -> Promise<[Movie]> in
                    return self.apiManager.getImages(movies: movieArray)
                }.done { (movies) in
                    items = [ListItemView]()
                    var count = 0
                    for movie in movies {
                        let item = ListItemView()
                        item.changeLabels(item: movie)
                        item.addAction {
                            layout.popup_alert.show()
                            self.apiManager.getDetails(movie: movie).done { (movie) in
                                layout.popup_alert.hide()
                                self.demonstrator.toDetailSheet()
                                self.exchangeFlow.letSelectedMovie(place: movie)
                            }.catch { (error) in
                                layout.popup_alert.changeAlertTitle(str: "Can't reach Details :/")
                                layout.popup_alert.showAlert()
                                print(error.localizedDescription)
                            }
                        }
                        items.append(item)
                        count += 1
                    }
                    layout.lv.addItems(items)
                    layout.popup_alert.hide()
                }.catch { (error) in
                    layout.popup_alert.hide()
                    print(error.localizedDescription)
                }
            }
            
            layout.ti.onEndEdit = {
                
                layout.popup_alert.show()
                
                if !((layout.ti.text ?? "").isEmpty) {
                    let word = layout.ti.text!
                    self.apiManager.searchList(str: word).then { (movieArray) -> Promise<[Movie]> in
                        return self.apiManager.getImages(movies: movieArray)
                    }.done { (movies) in
                        items = [ListItemView]()
                        layout.lv.reset()
                        var count = 0
                        for movie in movies {
                            let item = ListItemView()
                            item.changeLabels(item: movie)
                            item.addAction {
                                layout.popup_alert.show()
                                self.apiManager.getDetails(movie: movie).done { (movie) in
                                    layout.popup_alert.hide()
                                    self.demonstrator.toDetailSheet()
                                    self.exchangeFlow.letSelectedMovie(place: movie)
                                    Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
                                        AnalyticsParameterItemID: movie.imdbID,
                                        AnalyticsParameterItemName: movie.title,
                                        AnalyticsParameterContentType: movie.type
                                    ])
                                }.catch { (error) in
                                    layout.popup_alert.changeAlertTitle(str: "Can't reach Details :/")
                                    layout.popup_alert.showAlert()
                                    print(error.localizedDescription)
                                }
                            }
                            items.append(item)
                            count += 1
                        }
                        layout.lv.addItems(items)
                        layout.lv.setContentOffset(CGPoint(x: 0, y: -layout.lv.contentOffset.y), animated: false)
                        layout.popup_alert.hide()
                    }.catch { (error) in
                        layout.popup_alert.changeAlertTitle(str: "Nothing Found :(")
                        layout.popup_alert.showAlert()
                        print(error.localizedDescription)
                    }
                }
                else {

                }
                
                
                
            }
            
        }
        
    }
    
}
