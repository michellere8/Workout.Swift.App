//
//  PlannerViewController.swift
//  workout
//
//  Created by Michelle Tejeda on 2022-03-08.
//

import UIKit

class PlannerViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var task = [String]() // array of user entry task

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Workout" // title of the page
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //saving data set up making sure count starts at 0
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count") //number of task we currently have
        }
        updateTasks() // this will run the function to do a refresh
        
    }
    //refresh function
    func updateTasks(){
        
        task.removeAll() // this will remove any duplicates of the array
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        for x in 0..<count{
            if let taski = UserDefaults().value(forKey: "taski_\(x+1)") as? String {
                task.append(taski)
            }
        }
    
        tableView.reloadData()// this will reload al the user entries and push the new ones as well
    }
    
    // this is the function for the + button
    @IBAction func addrow(){
        let pvc = storyboard?.instantiateViewController(identifier: "listentry") as! listing
        pvc.title = "New Workout"
        pvc.update = {
            DispatchQueue.main.async{ // this allows you to use only 1 cell repetitevly
                self.updateTasks() // this sets the updateTask as a priority
            }
        }
        navigationController?.pushViewController(pvc, animated: true)
    }
}

// delegate function (this function sents you to listTask viewController when selectin the listed task)
extension PlannerViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let ltvc = storyboard?.instantiateViewController(identifier: "task") as! listTask
        ltvc.title = "Workout"
        ltvc.task = task[indexPath.row]
        
        navigationController?.pushViewController(ltvc, animated: true)
    }
    
}
// Data source function (supplies the number of rows )
extension PlannerViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listitem = tableView.dequeueReusableCell(withIdentifier: "listitem", for: indexPath)
        
        listitem.textLabel?.text = task[indexPath.row] // represents the possition of the row
        
        return listitem
    }
}
