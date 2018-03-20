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
    let testData = ["Apple", "Orange", "Blue Berries"]
    let cellReuseIdentifier = "cell"
    @IBOutlet weak var contentsView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.contentsView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        contentsView.dataSource = self
        contentsView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)
        cell?.textLabel?.text = self.testData[indexPath.row]
        return cell!
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("You tapped \(indexPath.row)")
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.testData.count
    }

    @IBAction func settingsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToSettings", sender: self)
    }
    
    @IBAction func savedFeedsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToSavedFeeds", sender: self)
    }
}

