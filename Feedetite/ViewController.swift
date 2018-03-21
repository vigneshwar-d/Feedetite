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
    @IBOutlet weak var contentsView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let feedContentsObject = FeedsContents()
        feedContentsObject.parse()
        contentsView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        contentsView.dataSource = self
        contentsView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        let testArray = ["Tesla relesed Model 3. Tesla relesed Model 3. Tesla relesed Model 3.","Apple released iPhone X","Rimac released C_2"]
        cell.cellLabel.text = testArray[indexPath.row]
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("You tapped \(indexPath.row)")
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    @IBAction func settingsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToSettings", sender: self)
    }
    
    @IBAction func savedFeedsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToSavedFeeds", sender: self)
    }
}

