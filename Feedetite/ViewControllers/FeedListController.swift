//
//  FeedListController.swift
//  Feedetite
//
//  Created by Vigneshwar Devendran on 05/04/18.
//  Copyright © 2018 Vigneshwar Devendran. All rights reserved.
//

import UIKit
import FeedKit

class FeedListController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var feedSourceUrl = "http://rss.cnn.com/rss/edition_world.rss"
    var feedSourceName = "CNN"
    var feedItemTitle = [String]()
    var feedItemUrl = [String]()
    var sourceIncrement = 0

    //var feedItemDate = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        tableView.rowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = feedSourceName
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "A button", style: .done, target: self, action: #sourceInc())
        tableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "feedCellCustom")
        parse()
    }
    
    //MARK: - TableView methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCellCustom", for: indexPath) as! FeedCell
        cell.titleView?.text = feedItemTitle[indexPath.row]
        //cell.timeView?.text = feedItemDate[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItemTitle.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        print("Parsing Successfull: \((result?.isSuccess)!)")
        
        switch result {
            
        case .some(.rss(_)):
            let feeds = result?.rssFeed
            for i in 0..<(feeds?.items?.count)!{
                var it = i
                let feedTitleAppend = (feeds?.items![it].title)
                let feedLinkAppend = (feeds?.items![it].link)
                it = it + 1
                self.feedItemTitle.append(feedTitleAppend!)
                self.feedItemUrl.append(feedLinkAppend!)
            }
            print("Current Source: \(feedSourceName)")

            
        case .some(.atom(_)):
                let feeds = result?.atomFeed
                for i in 0..<(feeds?.entries?.count)!{
                    var it = i
                    let feedTitleAppend = (feeds?.entries![it].title)
                    let feedLinkAppend = (feeds?.entries![it].id)
                    it = it + 1
                    self.feedItemTitle.append(feedTitleAppend!)
                    self.feedItemUrl.append(feedLinkAppend!)
                }
                print("Current Source: \(feedSourceName) \n")
        
            
        case .some(.json(_)):
            let feeds = result?.jsonFeed
            for i in 0..<(feeds?.items?.count)!{
                var it = i
                let feedTitleAppend = (feeds?.items![it].title)
                let feedLinkAppend = (feeds?.items![it].url)
                it = it + 1
                self.feedItemTitle.append(feedTitleAppend!)
                self.feedItemUrl.append(feedLinkAppend!)
            }
            print("Current Source: \(feedSourceName)")
            
        case .some(.failure(_)):
            print("Failed to parse feed")
        case .none:
            print("NONE")
        }
        
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        let nextSource = SourceViewController()
        sourceIncrement = sourceIncrement + 1
        nextSource.loadSelectedSources()
        feedSourceName = nextSource.sources[sourceIncrement]
        feedSourceUrl = nextSource.sourcesURL[sourceIncrement]
        feedItemTitle.removeAll()
        feedItemUrl.removeAll()
        parse()
        navigationItem.title = feedSourceName
        tableView.reloadData()
    }
    
    @IBAction func backPressed(_ sender: Any) {
        let previousSource = SourceViewController()
        sourceIncrement = sourceIncrement - 1
        previousSource.loadSelectedSources()
        feedSourceName = previousSource.sources[sourceIncrement]
        feedSourceUrl = previousSource.sourcesURL[sourceIncrement]
        feedItemTitle.removeAll()
        feedItemUrl.removeAll()
        parse()
        navigationItem.title = feedSourceName
        tableView.reloadData()
    }
}
