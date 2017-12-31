//
//  ItunesNetworkRequest.swift
//  FinalPod
//
//  Created by SV-work on 14.08.17.
//  Copyright © 2017 SV-work. All rights reserved.
//

import Foundation
class ItunesNetworkRequest : PodcastRequest {
    private var networkName : String
    
    
    private let searchStringStart = "https://itunes.apple.com/\(storeFront)/search?term="
    private let searchStringEnd = "&media=podcast&attribute=artistTerm"
    private var searchStringExplicit : String {
        if UserDefaults.standard.bool(forKey: "isExplicit") {
            return "&explicit=Yes"
        } else {
            return ""
        }
    }
    private var searchString : String {
        return searchStringStart + networkName + searchStringEnd + searchStringExplicit
    }
    override func getPodcastList () -> [Podcast] {
        var list = [Podcast]()
        let urlString = searchString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: urlString) else {return [Podcast]()}
        guard let data = try? Data(contentsOf: url) else {return [Podcast]()}
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            else {return [Podcast]()}
        if let dict = json as? [String : AnyObject] {
            if let result = dict["results"] as? [[String : AnyObject]] {
                var collectionID = ""
                for i in 0..<result.count {
                    if let _collectionId = result[i]["collectionId"] as? Int {
                        collectionID = String(_collectionId)
                        let podcast = Podcast(collectionItunesId: collectionID)
                        list.append(podcast)
                    }
                    
                }
            }
        }
        return list
    }
    init (networkName : String) {
        self.networkName = networkName
        super.init()
    }
}
