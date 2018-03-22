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
    var contentsArray: [String] = [String]()
    
    @IBOutlet weak var contentsView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        cell.cellLabel.text = contentsArray[indexPath.row]
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        print("You tapped \(indexPath.row)")
    //    }
    
    
    
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
            let feedAppend = (feeds?.items![it].title)
            //print("Trying to be media \(feeds?.image?.link)")
            it = it + 1
            print("Value in feedAppend \(feedAppend!)")
            self.contentsArray.append(feedAppend!)
            print((feeds?.items?.count)!)
        }
//        let feedAppend = (feeds?.items?.first?.title)
//        print("Value in feedAppend \(feedAppend!)")
//        self.contentsArray.append(feedAppend!)
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

