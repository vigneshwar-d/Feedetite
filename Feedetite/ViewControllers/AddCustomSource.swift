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
    func textField(_ sourceURL: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == " "){
            return false
        }
        return true
    }
    
    
    @IBAction func donePressed(_ sender: Any) {
        let checkNetwork = SourceViewController()
        if checkNetwork.isConnectedToNetwork() == true{
        print(sourceName.text!)
        print(sourceURL.text!)
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if sourceURL.text != ""{
            let feedURL = URL(string: sourceURL.text!)
            let parser = FeedParser(URL: feedURL!)
            let result = parser?.parse()
            
            if result?.isSuccess == true{
                print("Valid URL")
                let custObj = SourcesData(context: context)
                custObj.name = sourceName.text
                custObj.url = sourceURL.text
                custObj.selected = true
                custObj.sourceType = 1
                let save = IconManager()
                save.saveIcon(name: sourceName.text!, url: sourceURL.text!)
                let alert = UIAlertController(title: "Success!", message: "New Source Has Been Added.", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default) { (action) in
                    print("UI Alert Action Handler")
                    self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(action)
                alert.view.tintColor = UIColor.black
                present(alert, animated: true, completion: nil)
            }else{
                let failAlert = UIAlertController(title: "Error!", message: "Please Enter a Valid Feed Data", preferredStyle: .alert)
                let failAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    print("User Enterd an Invalid URL")
                }
            failAlert.addAction(failAction)
            failAlert.view.tintColor = UIColor.black
            present(failAlert, animated: true, completion: nil)
        }
        }else{
            let fillAlert = UIAlertController(title: "Error!", message: "Please fill out all the data", preferredStyle: .alert)
            let fillAction = UIAlertAction(title: "OK", style: .default) { (action) in
                print("User didn't filled correctly")
            }
            fillAlert.addAction(fillAction)
            fillAlert.view.tintColor = UIColor.black
            present(fillAlert, animated: true, completion: nil)
        }
        } 
        else{
            let alert = UIAlertController(title: "Oops!", message: "No Internet Connection", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
}


