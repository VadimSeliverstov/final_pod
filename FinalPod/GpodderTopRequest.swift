//
//  GpodderTopRequest.swift
//  FinalPod
//
//  Created by SV-work on 15.08.17.
//  Copyright © 2017 SV-work. All rights reserved.
//

import Foundation

class GpodderTopRequest : PodcastRequest {
    private var limit : Int
    
    private let searchStringStart = "http://www.gpodder.net/toplist/"
    private let searchStringEnd = ".json"
    private var searchStringLimit : String {
        return String(limit)
    }
    private var searchString : String {
        return searchStringStart + searchStringLimit + searchStringEnd
    }
    override func getPodcastList () -> [Podcast] {
        var list = [Podcast]()
        let urlString = searchString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: urlString) else {return [Podcast]()}
        guard let data = try? Data(contentsOf: url) else {return [Podcast]()}
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            else {return [Podcast]()}
        if let dict = json as? [[String : AnyObject]] {
            var collectionItunesId = 0
            var collectionLastWeekSubscriber = 0
            for i in 0..<dict.count {
                if let title = dict[i]["title"] as? String {
                    collectionItunesId = getCollectionID(title: title)
                }
                if let subscriber = dict[i]["subscribers_last_week"] as? Int {
                    collectionLastWeekSubscriber = subscriber
                }
                if collectionItunesId != 0 {
                    let podcast = Podcast(collectionItunesId : String(collectionItunesId), collectionLastWeekSubscriber: collectionLastWeekSubscriber)
                    list.append(podcast)
                }
            }
        }
        return list
    }
    
    private func getCollectionID (title : String) -> Int {
        var collectionID = 0
        let searchStringStart = "https://itunes.apple.com/\(PodcastRequest.storeFront)/search?term="
        let searchStringEnd = "&media=podcast&attribute=titleTerm"
        let searchString = searchStringStart + title + searchStringEnd
        let urlString = searchString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: urlString) else {return collectionID}
        guard let data = try? Data(contentsOf: url) else {return collectionID}
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            else {return collectionID}
        if let dict = json as? [String : AnyObject] {
            if let result = dict["results"] as? [[String : AnyObject]] {
                if result.count>0, let _collectionId = result[0]["collectionId"] as? Int {
                    collectionID = _collectionId
                }
            }
        }
        return collectionID
    }

    init (limit : Int) {
        self.limit = limit
        super.init()
    }
}
