//
//  AllSourcesViewController.swift
//  Feedetite
//
//  Created by Vigneshwar Devendran on 05/04/18.
//  Copyright © 2018 Vigneshwar Devendran. All rights reserved.
//

import UIKit
import CoreData

class AllSourcesViewController: UITableViewController{
    
    var allSourceArray = [SourcesData]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        navigationItem.title = "All available Sources"
        loadItems()
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allSourceCell", for: indexPath)
        cell.textLabel?.text = allSourceArray[indexPath.row].name
        cell.accessoryType = allSourceArray[indexPath.row].selected == true ? .checkmark : .none
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSourceArray.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        allSourceArray[indexPath.row].selected = !allSourceArray[indexPath.row].selected
        do{
            try context.save()
        }catch{
            print("Error saving data")
        }
        tableView.reloadData()
    }
    func loadItems(){
        let request: NSFetchRequest<SourcesData> = SourcesData.fetchRequest()
        do{
            try allSourceArray = context.fetch(request)
        }
        catch{
            print("Error fetching contents \(error)")
        }
    }
}
