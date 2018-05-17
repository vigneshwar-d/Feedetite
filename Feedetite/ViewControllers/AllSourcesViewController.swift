//
//  AllSourcesViewController.swift
//  Feedetite
//
//  Created by Vigneshwar Devendran on 05/04/18.
//  Copyright © 2018 Vigneshwar Devendran. All rights reserved.
//

import UIKit
import CoreData

class AllSourcesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var allSourceArray = [SourcesData]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "SourceCell", bundle: nil), forCellReuseIdentifier: "customSourceCell")
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.rowHeight = 50
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "ALL SOURCES"
        loadAllItems()
        
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customSourceCell", for: indexPath) as! SourceCell
        cell.sourceName.text = allSourceArray[indexPath.row].name
        cell.sourceImage.image = UIImage(named: cell.sourceName.text!)
        cell.accessoryType = allSourceArray[indexPath.row].selected == true ? .checkmark : .none
        return cell
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSourceArray.count
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        allSourceArray[indexPath.row].selected = !allSourceArray[indexPath.row].selected
        do{
            try context.save()
        }catch{
            print("Error saving data")
        }
        tableView.reloadData()
    }
    
    func loadAllItems(){
        let request: NSFetchRequest<SourcesData> = SourcesData.fetchRequest()
        do{
            try allSourceArray = context.fetch(request)
        }
        catch{
            print("Error fetching contents \(error)")
        }
    }
}
