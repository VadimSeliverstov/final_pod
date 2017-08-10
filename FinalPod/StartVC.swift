//
//  StartVC.swift
//  FinalPod
//
//  Created by SV-work on 04.08.17.
//  Copyright © 2017 SV-work. All rights reserved.
//

import UIKit

class StartVC: UIViewController {
    var iTunesRequest : Request!
    //Mark: - User Interface
    @IBOutlet var featuredCollectionView: UICollectionView!
    @IBOutlet var topCollectionView: UICollectionView!
    @IBOutlet var genreCollectionView: UICollectionView!
    @IBOutlet var networkCollectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global(qos: .userInteractive).async {
            self.iTunesRequest = Request(type: .ItunesUserRequest(userSearchString: "Маяк"))
        }
    }   
}
