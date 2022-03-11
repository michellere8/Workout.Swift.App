//
//  texBoxView.swift
//  workout
//
//  Created by Michelle Tejeda on 2022-03-10.
//

import UIKit


class texBoxView: UIViewController {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var noteLabel: UITextView!
    
    var task: String?
    public var note: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = task
        noteLabel.text = note
    }
    


}
