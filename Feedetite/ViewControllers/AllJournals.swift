//
//  JournalViewController.swift
//  Feedetite
//
//  Created by Vigneshwar Devendran on 11/05/18.
//  Copyright © 2018 Vigneshwar Devendran. All rights reserved.
//

import UIKit
import CoreData

class AllJournals: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var array = [Journal]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        array.removeAll()
        
        if UserDefaults.standard.string(forKey: "wasLaunchedFromJournal") != nil{
            print("Has been launched before")
        }else{
            print("App not launched")
            hardCodeJournals()
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "wasLaunchedFromJournal")
        }
        loadJournals()
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalNameCell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row].journalName
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func loadJournals(){
        //hardCodeJournals()
        let request: NSFetchRequest<Journal> = Journal.fetchRequest()
        do{
            try array = context.fetch(request)
        }
        catch{
            print("Error fetching contents \(error)")
        }
        tableView.reloadData()
    }
    func hardCodeJournals(){
        print("harCodeJournals called")
        let malasiyaFlight = Journal(context: context)
        malasiyaFlight.journalName = "MALASIYAN FLIGHT"
        do{
            try context.save()
        }catch{
            print("Error saving Journal")
        }
        
        
        let bermuda = Journal(context: context)
        bermuda.journalName = "Bermuda"
        do{
            try context.save()
        }catch{
            print("Error saving Journal")
        }
        
        let electriCars = Journal(context: context)
        electriCars.journalName = "Electric Cars"
        do{
            try context.save()
        }catch{
            print("Error saving Journal")
        }
    }

}

