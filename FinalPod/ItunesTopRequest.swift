//
//  ItunesTopRequest.swift
//  FinalPod
//
//  Created by SV-work on 14.08.17.
//  Copyright © 2017 SV-work. All rights reserved.
//

import Foundation

class ItunesTopRequest : PodcastRequest {
    private var limit : Int
    
    private let searchStringStart = "https://itunes.apple.com/\(storeFront)/rss/toppodcasts/limit="
    private let searchStringEnd = "/json"
    private var searchStringLimit : String {
        return String(limit)
    }
    private var searchStringExplicit : String {
        if UserDefaults.standard.bool(forKey: "isExplicit") {
            return "/explicit=true"
        } else {
            return ""
        }
    }
    private var searchString : String {
        return searchStringStart + searchStringLimit + searchStringExplicit + searchStringEnd
    }
    override func getPodcastList () -> [Podcast] {
        var list = [Podcast]()
        let urlString = searchString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: urlString) else {return [Podcast]()}
        guard let data = try? Data(contentsOf: url) else {return [Podcast]()}
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            else {return [Podcast]()}
        if let dict = json as? [String : AnyObject] {
            if let feed = dict["feed"] as? [String : AnyObject] {
                if let entry = feed["entry"] as? [[String : AnyObject]]{
                    for i in 0..<entry.count {
                        var collectionID = ""
                        if let id = entry[i]["id"] as? [String : AnyObject]{
                            if let attributes = id["attributes"] as? [String : AnyObject] {
                                if let imId = attributes["im:id"] as? String {
                                    collectionID = imId
                                }
                            }
                        }
                        let podcast = Podcast(collectionItunesId: collectionID)
                        list.append(podcast)
                    }
                }
            }
        }
        return list
    }
    init (limit : Int) {
        self.limit = limit
        super.init()
    }
}
