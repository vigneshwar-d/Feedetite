//
//  SourceViewController.swift
//  Feedetite
//
//  Created by Vigneshwar Devendran on 05/04/18.
//  Copyright © 2018 Vigneshwar Devendran. All rights reserved.
//

import UIKit

class SourceViewController: UITableViewController{
    
    
    //MARK: - Initializers
    let sources = ["CNN","Pop Sci"]
    let sourcesURL = ["http://rss.cnn.com/rss/edition.rss","https://www.popsci.com/full-feed/science"]
    
    
    override func viewDidLoad() {
        tableView.rowHeight = 70
    }
    
    
    //MARK: - TableView Functions
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sourceCell", for: indexPath)
        cell.textLabel?.text = sources[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToFeed", sender: self)
    }
    
    
    //MARK: - Prepare For Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! FeedListController
        destinationVC.feedSourceUrl = sourcesURL[(tableView.indexPathForSelectedRow?.row)!]
        destinationVC.feedSourceName = sources[(tableView.indexPathForSelectedRow?.row)!]
    }
}
