//
//  PodcastCell.swift
//  FinalPod
//
//  Created by SV-work on 15.08.17.
//  Copyright © 2017 SV-work. All rights reserved.
//

import UIKit

class PodcastCell: UITableViewCell {
    @IBOutlet var collID: UILabel!
    @IBOutlet var collSub: UILabel!
    @IBOutlet var collTitle: UILabel!
    @IBOutlet var collURL: UILabel!
    @IBOutlet var collAuthor: UILabel!
    @IBOutlet var collGenre: UILabel!
    @IBOutlet var collCount: UILabel!
    @IBOutlet var collUpdate: UILabel!
    @IBOutlet var collArt: UILabel!
    
    var podcast : Podcast!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateUI() {
        self.collID.text = podcast.collectionItunesId
        let collSub = String(describing: podcast.collectionLastWeekSubscriber)
        self.collSub.text = collSub
        self.collTitle.text = podcast.collectionTitle
        self.collURL.text = podcast.collectionFeedUrl
        self.collAuthor.text = podcast.collectionAuthor
        self.collGenre.text = podcast.collectionGenre
        self.collCount.text = String(describing: podcast.collectionTrackCount)
        self.collUpdate.text = podcast.collectionLastUpdate
        self.collArt.text = podcast.collectionArtworkUrl
    }
    func checkPodcast() {
        if self.podcast.collectionArtworkUrl == nil {
            DispatchQueue.global().async {
                self.podcast.podcastJsonUpdate()
                DispatchQueue.global().sync {
                    self.updateUI()
                }
            }
        } else {
            updateUI()
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
