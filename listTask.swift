//
//  listTask.swift
//  workout
//
//  Created by Michelle Tejeda on 2022-03-08.
//

import UIKit

class listTask: UIViewController, UITextViewDelegate{
    
    @IBOutlet var label: UILabel!
    @IBOutlet var noteBox: UITextView!
    
    //@IBOutlet weak var textBox: UILabel!
    
    var task: String?
    let userDefualts = UserDefaults()
    
    public var completion: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = task
        
        //if let value = UserDefaults.value(forKey: "text") as? String{
            //textBox.text = value
        //}
        
        noteBox.becomeFirstResponder()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didTapSave()
      return true
    }
    
    @objc func didTapSave() {
        if let text = noteBox.text, !text.isEmpty {
             completion?( noteBox.text)
          }
        UserDefaults.standard.set(noteBox.text, forKey: "text")
        
        
        navigationController?.popViewController(animated: true)
        
      }
    
    

}
