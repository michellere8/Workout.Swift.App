//
//  listing.swift
//  workout
//
//  Created by Michelle Tejeda on 2022-03-08.
//

import UIKit

class listing: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet var field: UITextField!
    
    var update: (() -> Void)? // 
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        field.delegate = self
        
        // this is the save button on the listingviewController
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
        
    }
    
    //this function allows the user to save their entry with keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
    
    // this function is to specify save entries
    @objc func saveTask(){
        
        guard let text = field.text, !text.isEmpty else {
            return
        }
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else{
            return
        }
        let newCount = count + 1
        UserDefaults().set(newCount, forKey: "count")
        UserDefaults().set(text, forKey: "taski_\(newCount)") // this is pointing the actual task that will be saved
        
        
        update?()
        navigationController?.popViewController(animated: true)
    }

    

}
