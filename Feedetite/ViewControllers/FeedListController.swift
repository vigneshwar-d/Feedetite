//
//  FeedListController.swift
//  Feedetite
//
//  Created by Vigneshwar Devendran on 05/04/18.
//  Copyright © 2018 Vigneshwar Devendran. All rights reserved.
//

import UIKit
import FeedKit
import ProgressHUD

class FeedListController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var feedSourceUrl = ""
    var feedSourceName = ""
    var feedItemTitle = [String]()
    var feedItemUrl = [String]()
    var sourceIncrement = 0
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(journalPressed))
        backButton.isEnabled = false
        backButton.setTitleColor(UIColor.gray, for: .normal)
        ProgressHUD.dismiss()
        navigationController?.navigationBar.prefersLargeTitles = false
        tableView.rowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = feedSourceName.uppercased()
        tableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "feedCellCustom")
        //parse()
    }
    
    //MARK: - TableView methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCellCustom", for: indexPath) as! FeedCell
        cell.titleView?.text = feedItemTitle[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItemTitle.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToWebView", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let addToJournal = UITableViewRowAction(style: .normal, title: "Add to Journal") { (action, indexPath) in
            print("\n\nSwiped\n\n")
        }
        addToJournal.backgroundColor = UIColor.black
        return [addToJournal]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToWebView" {
        let destinationVC = segue.destination as! WebViewForItem
        destinationVC.itemUrl = feedItemUrl[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    
    //MARK: - Parse Function
    func parse() {
        
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
        backButton.isEnabled = true
        backButton.setTitleColor(UIColor.white, for: .normal)
        let subscriptionCount = SourceViewController()
        subscriptionCount.loadSelectedSources()
        if sourceIncrement < subscriptionCount.sources.count-1{
        DispatchQueue.global(qos: .userInitiated).async {
            ProgressHUD.show()
            print(self.sourceIncrement)
            self.sourceIncrement = self.sourceIncrement + 1
            let previousSource = SourceViewController()
            previousSource.loadSelectedSources()
            self.feedSourceName = previousSource.sources[self.sourceIncrement]
            self.feedSourceUrl = previousSource.sourcesURL[self.sourceIncrement]
            self.feedItemTitle.removeAll()
            self.feedItemUrl.removeAll()
            self.parse()
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = self.feedSourceName.uppercased()
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
            }
        }
        }
        else{
            print("\n\nYou have the reached the end of the line\n\n")
            nextButton.isEnabled = false
            nextButton.setTitleColor(UIColor.gray, for: .normal)
        }
    }
    
    @IBAction func backPressed(_ sender: Any) {
        nextButton.isEnabled = true
        nextButton.setTitleColor(UIColor.white, for: .normal)
        print("Souce Increment: \(sourceIncrement)")
        if sourceIncrement > 0{
        DispatchQueue.global(qos: .userInitiated).async {
            ProgressHUD.show()
            self.sourceIncrement = self.sourceIncrement - 1
            let previousSource = SourceViewController()
            print("Souce Increment: \(self.sourceIncrement)")
            previousSource.loadSelectedSources()
            self.feedSourceName = previousSource.sources[self.sourceIncrement]
            self.feedSourceUrl = previousSource.sourcesURL[self.sourceIncrement]
            self.feedItemTitle.removeAll()
            self.feedItemUrl.removeAll()
            self.parse()
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = self.feedSourceName.uppercased()
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
            }
        }
        }else{
            print("\n\nYou are in the start line\n\n")
            backButton.isEnabled = false
            backButton.setTitleColor(UIColor.gray, for: .normal)
            
        }
    }
    @objc func journalPressed(){
        performSegue(withIdentifier: "goToJournal", sender: self)
    }
}
