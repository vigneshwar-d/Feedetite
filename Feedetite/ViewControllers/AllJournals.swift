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
        tableView.reloadData()
        
        
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
        performSegue(withIdentifier: "expandJournal", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteJournal = UITableViewRowAction(style: .destructive, title: "Delete Journal") { (action, indexPath) in
            self.alertFunc(index: indexPath.row)
        }
        tableView.reloadData()
        return [deleteJournal]
    }
    func alertFunc(index: Int){
        let alert = UIAlertController(title: "Are you sure?", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            let request: NSFetchRequest<Journal> = Journal.fetchRequest()
            do{
                let obj = try self.context.fetch(request)
                self.array.remove(at: index)
                self.context.delete(obj[index])
                //tableView.reloadData()
            }
            catch{
                print("Error deleting journal")
            }
            do{
                try self.context.save()
                self.tableView.reloadData()
            }catch{
                print("Error saving")
            }
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        //tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destinationVC = segue.destination as! JournalViewController
            if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedJournal = array[indexPath.row]
            }
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
        let readLater = Journal(context: context)
        readLater.journalName = "Read Later"
        do{
            try context.save()
        }catch{
            print("Error saving Journal")
        }
        
    }

}

