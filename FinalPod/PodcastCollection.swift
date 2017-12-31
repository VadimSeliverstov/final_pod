//
//  PodcastCollection.swift
//  FinalPod
//
//  Created by SV-work on 14.08.17.
//  Copyright © 2017 SV-work. All rights reserved.
//

import Foundation

class PodcastCollection {
    var list = [Podcast]()
    private var requestType : RequestType
    private var podcastRequest : PodcastRequest!
    
    private func formPodcastRequest() -> PodcastRequest {
        switch requestType {
        case .ItunesTopRequest(let limit):
            return ItunesTopRequest(limit: limit)
        case .ItunesGenreRequest (let genreId, let limit):
            return ItunesGenreRequest(genreId: genreId, limit: limit)
        case .ItunesUserRequest(let userSearchString):
            return ItunesUserRequest(userRequest: userSearchString)
        case .ItunesNetworkRequest(let networkName):
            return ItunesNetworkRequest(networkName: networkName)
        case .GpodderTopRequest (let limit):
            return GpodderTopRequest(limit: limit)
        }
    }
    
    init(ofType : RequestType) {
        self.requestType = ofType
        self.podcastRequest = self.formPodcastRequest()
        self.list = self.podcastRequest.getPodcastList()
    }
}

extension PodcastCollection {
    enum RequestType {
        case ItunesTopRequest (limit : Int)
        case ItunesGenreRequest (genreId : String, limit : Int)
        case ItunesUserRequest (userSearchString : String)
        case ItunesNetworkRequest (networkName : String)
        case GpodderTopRequest (limit : Int)
    }
}
