//
//  Collection.swift
//  FinalPod
//
//  Created by SV-work on 10.08.17.
//  Copyright © 2017 SV-work. All rights reserved.
//

import Foundation

class Collection : NSObject{
    var collectionItunesId : String?
    private var collectionTitle : String? {
        didSet {
            print(collectionTitle!)
        }
    }
    private var collectionAuthor : String?
    private var collectionDescription : String?
    private var collectionFeedUrl : String?
    private var collectionArtworkUrl : String?
    private var collectionGenre : String?
    private var collectionTrackCount : Int?
    var collectionLastUpdate : String?
    private var collectionEpisodeList : [Episode]?
    var feedParser : XMLParser?
    var firstEpisodeParser : XMLParser?
    var episodeParser : XMLParser?
    
    //Initialization with Itunes collection ID
    init (collectionItunesId : String?) {
        self.collectionItunesId = collectionItunesId
        super.init()
        self.jsonUpdate()
    }
    private func jsonUpdate () {
        var lookupString = ""
        if collectionItunesId != nil {
            lookupString = "https://itunes.apple.com/lookup?id=" + collectionItunesId!
        }
        guard let url = URL(string: lookupString) else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) {(data,response,error) in
            guard error == nil else { return }
            let status = (response as! HTTPURLResponse).statusCode
            guard status == 200 else { print(status); return }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    if let dict = json as? [String : AnyObject] {
                        if let result = dict["results"] as? [[String : AnyObject]] {
                            if let collectionName = result[0]["collectionName"] as? String {
                                self.collectionTitle = collectionName
                            }
                            if let collectionGenre = result[0]["primaryGenreName"] as? String {
                                self.collectionGenre = collectionGenre
                            }
                            if let collectionImageURL60 = result[0]["artworkUrl60"] as? String {
                                self.collectionArtworkUrl = collectionImageURL60
                            }
                            if let artistName = result[0]["artistName"] as? String {
                                self.collectionAuthor = artistName
                            }
                            if let releaseDate = result[0]["releaseDate"] as? String {
                                self.collectionLastUpdate = releaseDate
                            }
                            if let trackCount = result[0]["trackCount"] as? Int {
                                self.collectionTrackCount = trackCount
                            }
                            if let feedUrl = result[0]["feedUrl"] as? String {
                                self.collectionFeedUrl = feedUrl
                            }
                        }
                    }
                } catch {
                    print("Error deserializing JSON: \(error)")
                }

            }
        }
        task.resume()
    }
}
