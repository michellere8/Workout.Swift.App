//
//  ViewController.swift
//  workout
//
//  Created by Michelle Tejeda on 2022-02-28.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
            self.performSegue(withIdentifier: "menu", sender: nil)
        }
    }


}

