//
//  Movie.swift
//  Loodos
//
//  Created by Can Özcan on 27.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import UIKit

public struct Movie:Codable {
    
    public var title: String
    public var year: String
    public var imdbID: String
    public var type: String
    public var poster: String
    public var released: String?
    public var genre: String?
    public var director: String?
    public var actors: String?
    public var plot: String?
    public var language: String?
    public var country: String?
    public var imdbRating: String?


    public var image: UIImage? = nil
    
    enum CodingKeys: String, CodingKey {
        
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case poster = "Poster"
        case released = "Released"
        case genre = "Genre"
        case director = "Director"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case imdbID
        case imdbRating
        
    }
    
}
