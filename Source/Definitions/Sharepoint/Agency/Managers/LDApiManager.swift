//
//  LDApiManager.swift
//  Loodos
//
//  Created by Can Özcan on 27.01.2020.
//  Copyright © 2020 CanOzcan. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON
import PromiseKit
import Firebase

open class LDApiManager {
    
    public required init() {
        
    }
    
    private var sharepoint: LDSharepoint!
    
    private var agency: LDAgency!
    private var repository: LDRepository!
    
    private var manager: LDManager!
    
    private var eventManager: LDEventManager!
    private var networkManager: LDNetworkManager!
    
    private var dataStorage: LDDataStorage!
    private var persistentStorage: LDPersistentStorage!
    private var exchangeFlow: LDExchangeFlow!
    
    public func injectDependencies() {

        sharepoint = LDSharepoint.getInstance()
        agency = sharepoint.agency
        repository = sharepoint.repository
        manager =  agency.manager
        eventManager = manager.eventManager!
        networkManager = manager.networkManager!
        
        dataStorage = repository.dataStorage
        persistentStorage = repository.persistentStorage
        exchangeFlow = repository.exchangeFlow
        
    }
    
    public func checkConnection() -> Promise<String> {
        
        return Promise() { seal in
            Alamofire.request("https://google.com").validate().responseString() { response in
                switch response.result {
                case .success(let str):
                    seal.fulfill(str)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
        
    }
    
    public func getAppName(remoteConfig: RemoteConfig) -> Promise<String> {
        
        return Promise() { seal in
            
            let expirationDuration = 3600
            remoteConfig.fetch(withExpirationDuration: TimeInterval(expirationDuration)) { (status, error) -> Void in
                if status == .success {
                    remoteConfig.activate { (errActive) in
                        seal.fulfill(remoteConfig["appName"].stringValue!)
                    }
                } else {
                    seal.reject(error!)
                }
            }
            
        }
        
    }
    
    
    private var currentRequestURL = ""
    private var currentPage = 1
    
    
    public func searchList(pageNumber:Int=1, str: String) -> Promise<[Movie]> {
        return Promise() { seal in
            currentPage = pageNumber
            currentRequestURL = "http://omdbapi.com/?apikey=b70045d2&s=\(str)"
            print(str,"\(currentRequestURL)&page=\(pageNumber)")
            Alamofire.request("\(currentRequestURL)&page=\(pageNumber)".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!).validate().responseJSON() { response in
                switch response.result {
                    case .success(let jsonData):
                        guard let jsonDict = jsonData as? [String:Any] else {
                            return seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                        }
                        let json = JSON(jsonDict)
//                        print(jsonDict)
                        let decoder = JSONDecoder()
                        do {
                            let account = try decoder.decode([Movie].self, from: json["Search"].rawData())
                            seal.fulfill(account)
                        } catch let error {
                            seal.reject(error)
                            print("JSON Decode Error:\n \(error)")
                        }
                        
                    case .failure(let error):
                        seal.reject(error)
                }
            }
        }
    }
    
    public func nextList() -> Promise<[Movie]> {
        
        return Promise() { seal in
            currentPage += 1
            Alamofire.request("\(currentRequestURL)&page=\(currentPage)".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!).validate().responseJSON() { response in
                switch response.result {
                    case .success(let jsonData):
                        guard let jsonDict = jsonData as? [String:Any] else {
                            return seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                        }
                        let json = JSON(jsonDict)
//                        print(json.rawString()!)
                        let decoder = JSONDecoder()
                        do {
                            let account = try decoder.decode([Movie].self, from: json["Search"].rawData())
                            seal.fulfill(account)
                        } catch let error {
                            seal.reject(error)
                            print("JSON Decode Error:\n \(error)")
                        }
                        
                    case .failure(let error):
                        seal.reject(error)
                }
            }
        }
    }
    

    
    public func getImages(movies:[Movie]) -> Promise<[Movie]> {
        
        var updatedMovies = [Movie]()
        
        return Promise() { seal in
            var count = 0
            for movie in movies {
                var currentMovie = movie
                if movie.poster != "N/A" {
                    if let photoUrl = URL(string: "\(movie.poster)") {
                        if let photoData = try? Data(contentsOf: photoUrl)  {
                            if let photoImage = UIImage(data: photoData)  {
                                currentMovie.image = photoImage
                            }
                            else {
                                print("Failed downloading photo: \(count) \n Because of Serialization Error")
                            }
                        }
                        else {
                            print("Failed downloading photo: \(count) \n Because of Invalid URL")
                        }
                    }
                    else {
                        print("Failed downloading photo: \(count) \n Because of Invalid URL")
                    }
                }
                else {
                    print("Failed downloading photo: \(count) \n Because of Not Exist URL")
                }
                updatedMovies.append(currentMovie)
                count += 1
            }
            seal.fulfill(updatedMovies)
        }
            
    }
    
    public func getDetails(movie:Movie) -> Promise<Movie> {
        
        return Promise() { seal in
            
            Alamofire.request("http://omdbapi.com/?apikey=b70045d2&i=\(movie.imdbID)&plot=full".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!).validate().responseJSON() { response in
                switch response.result {
                    case .success(let jsonData):
                        guard let jsonDict = jsonData as? [String:Any] else {
                            return seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                        }
                        let json = JSON(jsonDict)
                        let decoder = JSONDecoder()
                        do {
                            var account = try decoder.decode(Movie.self, from: json.rawData())
                            account.image = movie.image
                            seal.fulfill(account)
                        } catch let error {
                            seal.reject(error)
                            print("JSON Decode Error:\n \(error)")
                        }
                        
                    case .failure(let error):
                        seal.reject(error)
                }
            }
            
        }
        
        
    }
        

}
