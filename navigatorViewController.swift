//
//  navigatorViewController.swift
//  workout
//
//  Created by Michelle Tejeda on 2022-03-11.
//

import UIKit

class navigatorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func wrkList(_ sender: Any) {
        performSegue(withIdentifier: "listing", sender: nil)
    }
    
    @IBAction func reminders(_ sender: Any) {
        performSegue(withIdentifier: "reminders", sender: nil)
    }
    
    @IBAction func timer(_ sender: Any) {
        performSegue(withIdentifier: "timmer", sender: nil)
    }
    
}
