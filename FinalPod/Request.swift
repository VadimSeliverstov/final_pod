//
//  Request.swift
//  FinalPod
//
//  Created by Vadim on 06.08.17.
//  Copyright © 2017 SV-work. All rights reserved.
//

import Foundation

class Request {
    private var request : RequestType
    var podcastList = [Collection]()
    init (type : RequestType) {
        self.request = type
        self.podcastList = self.request.jsonParsing()
    }
}

extension Request {
    internal enum RequestType {
        case ItunesTopRequest (limit : Int)
        case ItunesGenreRequest (genreId : String, limit : Int)
        case ItunesUserRequest (userSearchString : String)
        case ItunesNetworkRequest (networkName : String)
        private var storeFront : String {
            let currentLocale = Locale.current.regionCode!
            if STOREFRONTS.index(forKey: currentLocale) != nil {
                return currentLocale.lowercased()
            } else {
                return "us"
            }
        }
        private var searchStringStart : String {
            switch self {
            case .ItunesTopRequest, .ItunesGenreRequest:
                return "https://itunes.apple.com/\(storeFront)/rss/toppodcasts/limit="
            case .ItunesUserRequest, .ItunesNetworkRequest:
                return "https://itunes.apple.com/\(storeFront)/search?term="
            }
        }
        private var searchStringLimit : String {
            switch self {
            case .ItunesTopRequest(let limit):
                return String(limit)
            case .ItunesGenreRequest(_, let limit):
                return String(limit)
            case .ItunesUserRequest:
                return ""
            case .ItunesNetworkRequest:
                return ""
            }
        }
        private var searchStringKeyword : String {
            switch self {
            case .ItunesTopRequest:
                return ""
            case .ItunesGenreRequest(let genreId, _):
                return "/genre=\(genreId)"
            case .ItunesUserRequest(let userSearchString):
                return userSearchString
            case .ItunesNetworkRequest(let networkName):
                return networkName
            }
            
        }
        private var searchStringExplicit : String {
            switch self {
            case .ItunesTopRequest, .ItunesGenreRequest:
                if UserDefaults.standard.bool(forKey: "isExplicit") {
                    return "/explicit=true"
                } else {
                    return ""
                }
            case .ItunesUserRequest, .ItunesNetworkRequest:
                if UserDefaults.standard.bool(forKey: "isExplicit") {
                    return "&explicit=Yes"
                } else {
                    return ""
                }
            }
        }
        private var searchStringEnd : String {
            switch self {
            case .ItunesTopRequest, .ItunesGenreRequest:
                return "/json"
            case .ItunesUserRequest:
                return "&media=podcast"
            case .ItunesNetworkRequest:
                return "&media=podcast&attribute=artistTerm"
            }
        }
        private var searchString : String {
            switch self {
            case .ItunesTopRequest, .ItunesGenreRequest:
                return searchStringStart + searchStringLimit + searchStringKeyword + searchStringExplicit + searchStringEnd
            case .ItunesUserRequest, .ItunesNetworkRequest:
                return searchStringStart + searchStringKeyword + searchStringEnd + searchStringExplicit
                
            }
        }
        private var url : String {
            return searchString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        }
        fileprivate func jsonParsing () -> [Collection] {
            var collectionID = ""
            var list = [Collection]()
            switch self {
            case .ItunesTopRequest, .ItunesGenreRequest:
                guard let url = URL(string: url) else {return [Collection]()}
                guard let data = try? Data(contentsOf: url) else {return [Collection]()}
                guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    else {return [Collection]()}
                if let dict = json as? [String : AnyObject] {
                    if let feed = dict["feed"] as? [String : AnyObject] {
                        if let entry = feed["entry"] as? [[String : AnyObject]]{
                            for i in 0..<entry.count {
                                
                                if let id = entry[i]["id"] as? [String : AnyObject]{
                                    if let attributes = id["attributes"] as? [String : AnyObject] {
                                        if let imId = attributes["im:id"] as? String {
                                            collectionID = imId
                                        }
                                    }
                                }
                                let podcast = Collection(collectionItunesId: collectionID)
                                list.append(podcast)
                            }
                        }
                    }
                }
            case .ItunesUserRequest, .ItunesNetworkRequest:
                guard let url = URL(string: url) else {return [Collection]()}
                guard let data = try? Data(contentsOf: url) else {return [Collection]()}
                guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    else {return [Collection]()}
                if let dict = json as? [String : AnyObject] {
                    if let result = dict["results"] as? [[String : AnyObject]] {
                        
                        for i in 0..<result.count {
                            if let _collectionId = result[i]["collectionId"] as? Int {
                                collectionID = String(_collectionId)
                            }
                            let podcast = Collection(collectionItunesId: collectionID)
                            list.append(podcast)
                        }
                    }
                }
                
            }
            return list
        }
        var list : [Collection] {
            return self.jsonParsing()
        }
    }
}




