//
//  StartVC.swift
//  FinalPod
//
//  Created by SV-work on 04.08.17.
//  Copyright © 2017 SV-work. All rights reserved.
//

import UIKit

class StartVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var collection : PodcastCollection!
    //Mark: - User Interface
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        collection = PodcastCollection(ofType: .ItunesUserRequest(userSearchString: "Маяк"))
    }
}

extension StartVC : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collection.list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PodcastCell", for: indexPath) as! PodcastCell
        cell.podcast = collection.list[indexPath.row]
        cell.checkPodcast()
        return cell
    }
}
extension StartVC : UITableViewDelegate {
    
}
