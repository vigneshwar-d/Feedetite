//
//  JournalViewController.swift
//  Feedetite
//
//  Created by Vigneshwar Devendran on 17/05/18.
//  Copyright © 2018 Vigneshwar Devendran. All rights reserved.
//

import UIKit
import CoreData

class JournalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    var aTitleArray = [JournalContents]()
    var aLocationArray = [JournalContents]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedJournal: Journal?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadItems()
        tableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "feedCellCustom")
        tableView.reloadData()
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCellCustom", for: indexPath) as! FeedCell
        cell.titleView.text = aTitleArray[indexPath.row].articleTitle
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aTitleArray.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "webViewFromSegue", sender: self)
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let swipeAction = UITableViewRowAction(style: .destructive, title: "Remove Article") { (action, indexPath) in
            self.alertFunc(index: indexPath.row)
        }
        return [swipeAction]
    }
    func alertFunc(index: Int){
        let alert = UIAlertController(title: "Are you sure?", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes", style: .default) { (action) in
            do{
                let categoryPredicate = NSPredicate(format: "parentJournal.journalName MATCHES %@", (self.selectedJournal?.journalName!)!)
                let request: NSFetchRequest<JournalContents> = JournalContents.fetchRequest()
                request.predicate = categoryPredicate
                let obj = try self.context.fetch(request)
                self.aTitleArray.remove(at: index)
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
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! WebViewForItem
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.itemUrl = aLocationArray[indexPath.row].articleLink!
        }
    }
    func loadItems(){
        let categoryPredicate = NSPredicate(format: "parentJournal.journalName MATCHES %@", (selectedJournal?.journalName!)!)
        let request: NSFetchRequest<JournalContents> = JournalContents.fetchRequest()
        request.predicate = categoryPredicate
        
        do{
            aTitleArray = try context.fetch(request)
        }catch{
            print("Error in fetching: \(error)")
        }
        tableView.reloadData()
    }
}
