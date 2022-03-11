//
//  reminders.swift
//  workout
//
//  Created by Michelle Tejeda on 2022-03-07.
//
import UserNotifications
import UIKit

class reminders: UIViewController {
    
    @IBOutlet var table: UITableView!
    
    var models = [MyReminder]()

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
    }
    
    @IBAction func didTapAdd(){
        guard let vc = storyboard?.instantiateViewController(identifier: "add") as? addViewController else{
            return
        }
        vc.title = "New Reminder"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = {title, body, date in
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                let new = MyReminder(title: title, date: date, identifier: "id_\(title)")
                self.models.append(new)
                self.table.reloadData()
                
                let content = UNMutableNotificationContent()
                content.title = title
                content.sound = .default
                content.body = body

                let targetDate = date
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)

                let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                    if error != nil {
                        print("something went wrong")
                    }
                })
            }
            
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    

}
    
    extension reminders: UITableViewDelegate{
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    extension reminders: UITableViewDataSource{
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return models.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = models[indexPath.row].title
            let date = models[indexPath.row].date
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM, dd, YYYY"
            cell.detailTextLabel?.text = formatter.string(from: date)
            return cell
        }
    }
    
    struct MyReminder{
        let title: String
        let date: Date
        let identifier: String
    }
     


