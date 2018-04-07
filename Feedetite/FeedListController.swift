//
//  FeedListController.swift
//  Feedetite
//
//  Created by Vigneshwar Devendran on 05/04/18.
//  Copyright © 2018 Vigneshwar Devendran. All rights reserved.
//

import UIKit
import FeedKit

class FeedListController: UITableViewController{
    var feedSourceUrl = ""
    var feedSourceName = ""
    var feedItemTitle = [String]()
    var feedItemUrl = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        navigationItem.title = feedSourceName
        parse()
    }
    
    
    //MARK: - TableView methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath)
        cell.textLabel?.text = feedItemTitle[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItemTitle.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToWebView", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! WebViewForItem
        destinationVC.itemUrl = feedItemUrl[(tableView.indexPathForSelectedRow?.row)!]
    }
    
    
    //MARK: - Parse Function
    func parse(){
        let feedURL = URL(string: feedSourceUrl)
        let parser = FeedParser(URL: feedURL!)
        let result = parser?.parse()
        print((result?.isSuccess)!)
        switch result {
        case .some(.rss(_)):
            let feeds = result?.rssFeed
            for i in 0..<10{
                var it = i
                let feedTitleAppend = (feeds?.items![it].title)
                let feedLinkAppend = (feeds?.items![it].link)
                //print("Trying to be media \(feeds?.image?.link)")
                it = it + 1
                print("Value in feedAppend \(feedTitleAppend!)")
                self.feedItemTitle.append(feedTitleAppend!)
                self.feedItemUrl.append(feedLinkAppend!)
                print((feeds?.items?.count)!)
            }
        case .some(.atom(_)):
                let feeds = result?.atomFeed
                for i in 0..<10{
                    var it = i
                    let feedTitleAppend = (feeds?.entries![it].title)
                    let feedLinkAppend = (feeds?.entries![it].id)
                    //print("Trying to be media \(feeds?.image?.link)")
                    it = it + 1
                    print("Value in feedAppend \(feedTitleAppend!)")
                    self.feedItemTitle.append(feedTitleAppend!)
                    self.feedItemUrl.append(feedLinkAppend!)
                    print((feeds?.entries?.count)!)
            }
        
        case .some(.json(_)):
            print("JSON support coming soon")
        case .some(.failure(_)):
            print("Failed to parse feed")
        case .none:
            print("NONE")
        }
        
    }
}
