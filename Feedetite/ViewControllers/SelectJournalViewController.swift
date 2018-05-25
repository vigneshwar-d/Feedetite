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
        print("Nothing at the moment")
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
        dismiss(animated: true, completion: nil)
    }
    }


