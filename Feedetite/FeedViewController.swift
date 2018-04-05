//
//  ViewController.swift
//  Feedetite
//
//  Created by Vigneshwar Devendran on 18/03/18.
//  Copyright © 2018 Vigneshwar Devendran. All rights reserved.
//

import UIKit
import FeedKit

class FeedViewController: UITableViewController {
    var feedTitleArray = [String]()
    var feedLinkArray = [String]()
    var rssLink = ""
    var feedName = ""
    override func viewDidLoad() {
        tableView.rowHeight = 70
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath)
        cell.textLabel?.text = feedTitleArray[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedTitleArray.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
