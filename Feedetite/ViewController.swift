//
//  ViewController.swift
//  Feedetite
//
//  Created by Vigneshwar Devendran on 18/03/18.
//  Copyright © 2018 Vigneshwar Devendran. All rights reserved.
//

import UIKit
import FeedKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var contentTitleArray: [String] = [String]()
    var contentLinkArray: [String] = [String]()
    var linkPath: Int = 0
    
    @IBOutlet weak var contentsView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        cell.cellLabel.text = contentTitleArray[indexPath.row]
        return cell
    }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            let feedContentsObj = FeedsContents()
//            print("To be send to we view \(contentLinkArray[indexPath.row])")
//            feedContentsObj.feedLink = contentLinkArray[indexPath.row]
//            linkPath = indexPath.row
//            print(feedContentsObj.feedLink)
            tableView.deselectRow(at: indexPath, animated: true)
            performSegue(withIdentifier: "goToWebView", sender: self)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToWebView"{
            let webVC = segue.destination as! WebViewForFeedItem
            webVC.feedLink = self.contentLinkArray[linkPath]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        contentsView.delegate = self
        contentsView.dataSource = self
        contentsView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customCell")
        parse()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
    func parse(){
        //let feedURL = URL(string: "https://www.popsci.com/rss-science.xml?loc=contentwell&lnk=science&dom=section-1")
        let feedURL = URL(string: "http://rss.cnn.com/rss/edition.rss")
        let parser = FeedParser(URL: feedURL!)
        let result = parser?.parse()
        print((result?.isSuccess)!)
        let feeds = result?.rssFeed
        for i in 0..<((feeds?.items?.count)!){
            var it = i
            let feedTitleAppend = (feeds?.items![it].title)
            let feedLinkAppend = (feeds?.items![it].link)
            //print("Trying to be media \(feeds?.image?.link)")
            it = it + 1
            print("Value in feedAppend \(feedTitleAppend!)")
            self.contentTitleArray.append(feedTitleAppend!)
            self.contentLinkArray.append(feedLinkAppend!)
            print((feeds?.items?.count)!)
        }
//        let feedAppend = (feeds?.items?.first?.title)
//        print("Value in feedAppend \(feedAppend!)")
//        self.contentTitleArray.append(feedAppend!)
//        print((feeds?.items![1].title)!)
//        print((feeds?.items?.count)!)
    }

    @IBAction func settingsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToSettings", sender: self)
    }
    
    @IBAction func savedFeedsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToSavedFeeds", sender: self)
    }
}

