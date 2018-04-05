//
//  SourceViewController.swift
//  Feedetite
//
//  Created by Vigneshwar Devendran on 05/04/18.
//  Copyright © 2018 Vigneshwar Devendran. All rights reserved.
//

import UIKit

class SourceViewController: UITableViewController{
    
    
    //MARK: - Initializers
    let sources = ["CNN","Pop Sci"]
    let sourcesURL = ["http://rss.cnn.com/rss/edition.rss","https://www.popsci.com/full-feed/science"]
    
    
    override func viewDidLoad() {
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        if UserDefaults.standard.string(forKey: "wasLaunched") != nil{
            print("Has been launched before")
        }else{
            print("App not launched")
            setSourceBase()
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "wasLaunched")
        }
        
        tableView.rowHeight = 70
        

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
        
        //2
        let nytimes = SourcesData(context: context)
        nytimes.name = "The New York Times"
        nytimes.url = "https://www.nytimes.com/services/xml/rss/nyt/World.xml"
        
        //3
        let guardian = SourcesData(context: context)
        guardian.name = "The Guardian"
        guardian.url = "https://www.theguardian.com/world/rss"
        
        //4
        let bbc = SourcesData(context: context)
        bbc.name = "BBC"
        bbc.url = "http://feeds.bbci.co.uk/news/world/rss.xml"
        
        //5
        let reuters = SourcesData(context: context)
        reuters.name = "Reuters"
        reuters.url = "http://feeds.reuters.com/reuters/INhollywood"
        
        //6
        let theatlantic = SourcesData(context: context)
        theatlantic.name = "The Atlantic"
        theatlantic.url = "https://www.theatlantic.com/feed/channel/education/"
        
        //7
        let time = SourcesData(context: context)
        time.name = "TIME"
        time.url = "http://feeds.feedburner.com/time/healthland"
        
        //8
        let theverge = SourcesData(context: context)
        theverge.name = "The Verge"
        theverge.url = "http://www.theverge.com/apple/rss/index.xml"
        
        //9
        let motortrend = SourcesData(context: context)
        motortrend.name = "Motor Trend"
        motortrend.url = "http://www.motortrend.com/widgetrss/motortrend-future.xml"
        
        do{
            try context.save()
        }catch{
            print("Error saving data")
        }
    }
    

    @IBAction func addButtonPressedInSource(_ sender: Any) {
        performSegue(withIdentifier: "goToSources", sender: self)
    }
}
