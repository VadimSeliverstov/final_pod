//
//  PodcastRequest.swift
//  FinalPod
//
//  Created by SV-work on 14.08.17.
//  Copyright © 2017 SV-work. All rights reserved.
//

import Foundation

class PodcastRequest {
    static var storeFront : String {
        let currentLocale = Locale.current.regionCode!
        if STOREFRONTS.index(forKey: currentLocale) != nil {
            return currentLocale.lowercased()
        } else {
            return "us"
        }
    }
    func getPodcastList () -> [Podcast] {
        let list = [Podcast]()
        return list
    }
}









