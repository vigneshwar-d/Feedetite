//
//  SelectJournalViewController.swift
//  Feedetite
//
//  Created by Vigneshwar Devendran on 25/05/18.
//  Copyright © 2018 Vigneshwar Devendran. All rights reserved.
//

import UIKit
import CoreData


class SelectJournalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var journalList = [Journal]()
    var articleName = ""
    var articleLocation = ""
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadJournals()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalNameList", for: indexPath)
        cell.textLabel?.text = journalList[indexPath.row].journalName
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journalList.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contents = JournalContents(context: context)
        contents.parentJournal = self.journalList[indexPath.row]
        contents.articleTitle = articleName
        contents.articleLink = articleLocation
        do{
            try context.save()
        }catch{
            print("There could be a problem")
        }
        let alert = UIAlertController(title: "Success!", message: "Article has been saved.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func loadJournals(){
        let request: NSFetchRequest<Journal> = Journal.fetchRequest()
        do{
            try journalList = context.fetch(request)
        }
        catch{
            print("Error fetching contents \(error)")
        }
        tableView.reloadData()
    }
    @IBAction func createPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Enter Journal Name", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "DONE", style: .default) { (action) in
            let newItem = Journal(context: self.context)
            newItem.journalName = textField.text
            self.journalList.append(newItem)
            do{
                try self.context.save()
            }catch{
                print("Error saving context \(error)")
            }
            let contents = JournalContents(context: self.context)
            contents.parentJournal = self.journalList.last
            contents.articleTitle = self.articleName
            contents.articleLink = self.articleLocation
            do{
                try self.context.save()
            }catch{
                print("There could be problem 00(")
            }
            self.dismiss(animated: true, completion: nil)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter new journal name"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}


