//
//  Podcast.swift
//  FinalPod
//
//  Created by SV-work on 15.08.17.
//  Copyright © 2017 SV-work. All rights reserved.
//

import Foundation

class Podcast : NSObject {
    //MARK: - Primary initialisation variables
    var collectionItunesId : String
    var collectionLastWeekSubscriber : Int? //Nil with iTunes Initialization
    //MARK: - JSON update variables
    var collectionTitle : String?
    var collectionFeedUrl : String?
    var collectionAuthor : String?
    var collectionGenre : String?
    var collectionTrackCount : Int?
    var collectionLastUpdate : String?//Remove to XML Parsing
    var collectionArtworkUrl : String?
    
    
    //MARK: - Feed XML Parsing variables
     private var collectionDescription : String?
    //MARK: - Episode XML Parsing variable
    private var collectionEpisodeList : [Episode]?
    
    private var feedParser : XMLParser?
    private var firstEpisodeParser : XMLParser?
    private var episodeParser : XMLParser?
    //MARK: - Initialisation
    //Initialization with Itunes collection ID
    init (collectionItunesId : String) {
        self.collectionItunesId = collectionItunesId
        self.collectionLastWeekSubscriber = 0
        super.init()
        self.podcastJsonUpdate()
    }
    //Initialization with Gpodder collection Title
    init (collectionItunesId : String, collectionLastWeekSubscriber : Int?) {
        self.collectionItunesId = collectionItunesId
        self.collectionLastWeekSubscriber = collectionLastWeekSubscriber
        super.init()
        self.podcastJsonUpdate()
    }
    func getLookupUrl (_ id : String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "itunes.apple.com"
        urlComponents.path = "/lookup"
        let itunesID = URLQueryItem(name: "id", value: id)
        urlComponents.queryItems = [itunesID]
        return urlComponents.url
    }
    
    //MARK: - JSON Update
    func podcastJsonUpdate () {
        guard let url = getLookupUrl(collectionItunesId.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {return}
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
                            if let collectionTitle = result[0]["collectionName"] as? String {
                                self.collectionTitle = collectionTitle
                            }
                            if let collectionFeedUrl = result[0]["feedUrl"] as? String {
                                self.collectionFeedUrl = collectionFeedUrl
                            }
                            if let collectionAuthor = result[0]["artistName"] as? String {
                                self.collectionAuthor = collectionAuthor
                            }
                            if let collectionGenre = result[0]["primaryGenreName"] as? String {
                                self.collectionGenre = collectionGenre
                            }
                            if let collectionTrackCount = result[0]["trackCount"] as? Int {
                                self.collectionTrackCount = collectionTrackCount
                            }
                            if let collectionLastUpdate = result[0]["releaseDate"] as? String {
                                self.collectionLastUpdate = collectionLastUpdate
                            }
                            if let collectionImageURL60 = result[0]["artworkUrl60"] as? String {
                                self.collectionArtworkUrl = collectionImageURL60
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


extension Podcast : XMLParserDelegate {
    
}
