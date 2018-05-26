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
    var rowToAddToJournal: Int = 0
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(journalPressed))
        ProgressHUD.dismiss()
        navigationController?.navigationBar.prefersLargeTitles = false
        tableView.rowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = feedSourceName
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
            self.rowToAddToJournal = indexPath.row
            self.swipeAction()
        }
        addToJournal.backgroundColor = UIColor.black
        return [addToJournal]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToWebView" {
        let destinationVC = segue.destination as! WebViewForItem
        destinationVC.itemUrl = feedItemUrl[(tableView.indexPathForSelectedRow?.row)!]
        }
        else if segue.identifier == "addToAJournal" {
            let destinationVC = segue.destination as! SelectJournalViewController
            destinationVC.articleName = feedItemTitle[rowToAddToJournal]
            destinationVC.articleLocation = feedItemUrl[rowToAddToJournal]
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
    
    func swipeAction(){
        performSegue(withIdentifier: "addToAJournal", sender: self)
    }
    
    
}
