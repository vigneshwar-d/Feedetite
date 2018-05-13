//
//  SourceViewController.swift
//  Feedetite
//
//  Created by Vigneshwar Devendran on 05/04/18.
//  Copyright © 2018 Vigneshwar Devendran. All rights reserved.
//

import UIKit
import CoreData
import SVProgressHUD
import Alamofire
import FeedKit

class SourceViewController: UITableViewController{
    
    
    //MARK: - Initializers
    var sources = [String]()
    var sourcesURL = [String]()
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
//        if UserDefaults.standard.string(forKey: "wasLaunched") != nil{
//            print("Has been launched before")
//        }else{
//            print("App not launched")
//            setSourceBase()
//            let defaults = UserDefaults.standard
//            defaults.set(true, forKey: "wasLaunched")
//        }
//        loadSelectedSources()
//        tableView.rowHeight = 70
//    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.register(UINib(nibName: "SourceCell", bundle: nil), forCellReuseIdentifier: "customSourceCell")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Your Subscriptions"
        sources.removeAll()
        sourcesURL.removeAll()
        super.viewWillAppear(animated)
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        if UserDefaults.standard.string(forKey: "wasLaunched") != nil{
            print("Has been launched before")
        }else{
            print("App not launched")
            setSourceBase()
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "wasLaunched")
        }
        loadSelectedSources()
        //tableView.rowHeight = 50
        tableView.reloadData()
    }
    
    func isConnectedToNetwork() -> Bool{
        return NetworkReachabilityManager()!.isReachable
    }
    //MARK: - TableView Functions
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customSourceCell", for: indexPath) as! SourceCell
        cell.sourceName.text = sources[indexPath.row]
        cell.sourceImage.image = UIImage(named: sources[indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isConnectedToNetwork() == false{
            let alert = UIAlertController(title: "Oops!", message: "No Internet Connection", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(action)
            alert.view.tintColor = UIColor.black
            present(alert, animated: true, completion: nil)
            tableView.deselectRow(at: indexPath, animated: true)
        }else{
        performSegue(withIdentifier: "goToFeed", sender: self)
        }
    }
    //MARK: - Prepare For Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToFeed"{
        let destinationVC = segue.destination as! FeedListController
        destinationVC.feedSourceUrl = sourcesURL[(tableView.indexPathForSelectedRow?.row)!]
        destinationVC.feedSourceName = sources[(tableView.indexPathForSelectedRow?.row)!]
        destinationVC.parse()
        
        
        }
    }
    func setSourceBase(){
        print("setSourceBase called")
        //var array = [SourcesData]()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //1
        let cnn = SourcesData(context: context)
        cnn.name = "CNN"
        cnn.url = "http://rss.cnn.com/rss/edition_world.rss"
        cnn.selected = false
        cnn.sourceType = 0
        
        //2
        let nytimes = SourcesData(context: context)
        nytimes.name = "The New York Times"
        nytimes.url = "https://www.nytimes.com/services/xml/rss/nyt/World.xml"
        nytimes.selected = false
        nytimes.sourceType = 0
        
        //3
        let guardian = SourcesData(context: context)
        guardian.name = "The Guardian"
        guardian.url = "https://www.theguardian.com/world/rss"
        guardian.selected = false
        guardian.sourceType = 0
        
        //4
        let bbc = SourcesData(context: context)
        bbc.name = "BBC"
        bbc.url = "http://feeds.bbci.co.uk/news/world/rss.xml"
        bbc.selected = false
        bbc.sourceType = 0
        
        //5
        let reuters = SourcesData(context: context)
        reuters.name = "Reuters"
        reuters.url = "http://feeds.reuters.com/reuters/INhollywood"
        reuters.selected = false
        reuters.sourceType = 0
        
        //6
        let theatlantic = SourcesData(context: context)
        theatlantic.name = "The Atlantic"
        theatlantic.url = "https://www.theatlantic.com/feed/channel/education/"
        theatlantic.selected = false
        theatlantic.sourceType = 0
        
        //7
        let time = SourcesData(context: context)
        time.name = "TIME"
        time.url = "http://feeds.feedburner.com/time/healthland"
        time.selected = false
        time.sourceType = 0
        
        //8
        let theverge = SourcesData(context: context)
        theverge.name = "The Verge"
        theverge.url = "http://www.theverge.com/apple/rss/index.xml"
        theverge.selected = false
        theverge.sourceType = 0
        
        //9
        let motortrend = SourcesData(context: context)
        motortrend.name = "Motor Trend"
        motortrend.url = "http://www.motortrend.com/widgetrss/motortrend-future.xml"
        motortrend.selected = false
        motortrend.sourceType = 0
        
        do{
            try context.save()
        }catch{
            print("Error saving data")
        }
    }
    
    func loadSelectedSources(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var localArray = [SourcesData]()
        let request: NSFetchRequest<SourcesData> = SourcesData.fetchRequest()
        let predicate = NSPredicate(format: "selected == true")
        request.predicate = predicate
        do{
            localArray = try context.fetch(request)
        }catch{
            print("Error getting data with predicate")
        }
        for i in 0..<localArray.count{
            sources.append(localArray[i].name!)
            sourcesURL.append(localArray[i].url!)
            //tableView.reloadData()
        }
    }
    
    
    @IBAction func journalPressed(_ sender: UIBarButtonItem) {
        print("Journal Button Pressed")
        performSegue(withIdentifier: "goToJournal", sender: self)
    }
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "allExistingSources", sender: self)
}
}
