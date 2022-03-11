//
//  timer.swift
//  workout
//
//  Created by Michelle Tejeda on 2022-03-05.
//

import UIKit

class timer: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var restart: UIButton!
    @IBOutlet weak var startbtn: UIButton!
    @IBOutlet weak var timerlb: UILabel!
    
    var timer: Timer = Timer();
    var count: Int = 0
    var timerCount: Bool = false
    var lapTimeArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startbtn.setTitleColor(UIColor.green, for: .normal)
    }
    
    @IBAction func resetbtn(_ sender: Any) {
        let alert = UIAlertController(title: "Reset timer?", message: "Are you sure you want to restart?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            //do nothing
        }))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            self.count = 0
            self.timer.invalidate()
            self.timerlb.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
        }))
        //self.lapTimeArray.removeAll()
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func startStop(_ sender: Any) {
        if(timerCount){
            timerCount = false
            timer.invalidate()
            startbtn.setTitle("Start", for: .normal)
            startbtn.setTitleColor(UIColor.green, for: .normal)
            
            
        }else {
            timerCount = true
            startbtn.setTitle("Stop", for: .normal)
            startbtn.setTitleColor(UIColor.orange, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            
        }
        
    }
    
    @objc func timerCounter() -> Void {
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        timerlb.text = timeString
    }
        
        
        
        func secondsToHoursMinutesSeconds(seconds:Int)->(Int,Int,Int){
            return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
        }
        
        func makeTimeString(hours: Int, minutes:Int, seconds:Int) -> String{
            var timeString = ""
                    timeString += String(format: "%02d", hours)
                    timeString += " : "
                    timeString += String(format: "%02d", minutes)
                    timeString += " : "
                    timeString += String(format: "%02d", seconds)
                    return timeString
        }
    
    @IBAction func lapbtn(_ sender: Any) {
        lapTimeArray.append(timerlb.text!)
                tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lapRecordCell")
                cell?.textLabel?.text = lapTimeArray[indexPath.row]
                return cell!
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapTimeArray.count
    }
    
    // deleting rows
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return.delete
    }
    
    // this function re arrenges list so there are no empty rows when deliting
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            lapTimeArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

