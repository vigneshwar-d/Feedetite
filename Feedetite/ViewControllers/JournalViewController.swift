//
//  JournalViewController.swift
//  Feedetite
//
//  Created by Vigneshwar Devendran on 17/05/18.
//  Copyright © 2018 Vigneshwar Devendran. All rights reserved.
//

import UIKit
import CoreData

class JournalViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var anArray = [JournalContents]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
}
