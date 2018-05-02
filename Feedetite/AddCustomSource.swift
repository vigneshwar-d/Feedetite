//
//  AddCustomSource.swift
//  Feedetite
//
//  Created by Vigneshwar Devendran on 01/05/18.
//  Copyright © 2018 Vigneshwar Devendran. All rights reserved.
//

import UIKit
import FeedKit

class AddCustomSource: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var sourceName: UITextField!
    @IBOutlet weak var sourceURL: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        sourceURL.delegate = self
        sourceName.delegate = self
        navigationItem.title = "Add Custom Source"
        print("Add Custom Source called")
    }
    @IBAction func donePressed(_ sender: Any) {
        print(sourceName.text!)
        print(sourceURL.text!)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
