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
        print(contentsArray.count)
        return contentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        cell.cellLabel.text = contentsArray[indexPath.row]
        print("The cell has \(cell.cellLabel.text!)")
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
        print("Contents Array has \(contentsArray)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
    func parse(){
        let feedURL = URL(string: "https://www.popsci.com/rss-science.xml?loc=contentwell&lnk=science&dom=section-1")
        let parser = FeedParser(URL: feedURL!)
        let result = parser?.parse()
        print(result?.isSuccess)
        let feeds = result?.rssFeed
        let feedAppend = (feeds?.items?.first?.title)
        print(feedAppend!)
        self.contentsArray.append(feedAppend!)
        print(feedAppend!)
//        parser?.parse(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
//            // Do your thing, then back to the Main thread
//            DispatchQueue.main.async {
//                // ..and update the UI
//                print(result.isSuccess)
//                let feeds = result.rssFeed
//                let feedAppend = (feeds?.items?.first?.title)!
//                print(feedAppend)
////                let contentObj = FeedsContents()
////                contentObj.feedTitle = feedAppend
//                self.contentsArray.append(feedAppend)
//                print(self.contentsArray)
//            }
//        }
    }

    @IBAction func settingsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToSettings", sender: self)
    }
    
    @IBAction func savedFeedsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToSavedFeeds", sender: self)
    }
}

