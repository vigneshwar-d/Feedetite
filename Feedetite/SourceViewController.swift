//
//  SourceViewController.swift
//  Feedetite
//
//  Created by Vigneshwar Devendran on 05/04/18.
//  Copyright © 2018 Vigneshwar Devendran. All rights reserved.
//

import UIKit
import CoreData

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
        tableView.rowHeight = 50
        tableView.reloadData()
    }
    
    
    //MARK: - TableView Functions
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sourceCell", for: indexPath)
        cell.textLabel?.text = sources[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToFeed", sender: self)

    }
    
    
    //MARK: - Prepare For Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFeed"{
        let destinationVC = segue.destination as! FeedListController
        destinationVC.feedSourceUrl = sourcesURL[(tableView.indexPathForSelectedRow?.row)!]
        destinationVC.feedSourceName = sources[(tableView.indexPathForSelectedRow?.row)!]
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
        
        //2
        let nytimes = SourcesData(context: context)
        nytimes.name = "The New York Times"
        nytimes.url = "https://www.nytimes.com/services/xml/rss/nyt/World.xml"
        nytimes.selected = false
        
        //3
        let guardian = SourcesData(context: context)
        guardian.name = "The Guardian"
        guardian.url = "https://www.theguardian.com/world/rss"
        guardian.selected = false
        
        //4
        let bbc = SourcesData(context: context)
        bbc.name = "BBC"
        bbc.url = "http://feeds.bbci.co.uk/news/world/rss.xml"
        bbc.selected = false
        
        //5
        let reuters = SourcesData(context: context)
        reuters.name = "Reuters"
        reuters.url = "http://feeds.reuters.com/reuters/INhollywood"
        reuters.selected = false
        
        //6
        let theatlantic = SourcesData(context: context)
        theatlantic.name = "The Atlantic"
        theatlantic.url = "https://www.theatlantic.com/feed/channel/education/"
        theatlantic.selected = false
        
        //7
        let time = SourcesData(context: context)
        time.name = "TIME"
        time.url = "http://feeds.feedburner.com/time/healthland"
        time.selected = false
        
        //8
        let theverge = SourcesData(context: context)
        theverge.name = "The Verge"
        theverge.url = "http://www.theverge.com/apple/rss/index.xml"
        theverge.selected = false
        
        //9
        let motortrend = SourcesData(context: context)
        motortrend.name = "Motor Trend"
        motortrend.url = "http://www.motortrend.com/widgetrss/motortrend-future.xml"
        motortrend.selected = false
        
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
    
    
    @IBAction func addButtonPressedInSource(_ sender: Any) {
        performSegue(withIdentifier: "goToSources", sender: self)
    }
}
