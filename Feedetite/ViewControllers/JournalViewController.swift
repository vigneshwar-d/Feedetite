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
        tableView.reloadData()
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalContentCell", for: indexPath)
        cell.textLabel?.text = aTitleArray[indexPath.row].articleTitle
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aTitleArray.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "webViewFromSegue", sender: self)
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
