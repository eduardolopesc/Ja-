import UIKit
import CoreMotion
import UserNotifications

class NotificationsViewController: UIViewController {
    
    let activityManager = CMMotionActivityManager()
       let pedometer = CMPedometer()
       

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func datePickerChange(_ sender: UIDatePicker) {
        let center = UNUserNotificationCenter.current()
        
              // create the notification content
                let content = UNMutableNotificationContent()
                content.title = "Vamos correr novamente?"
                content.body = "1,2,3... Já!"
                content.sound = .default

                    
                let date = datePicker.date
                
                // create a Calender instance
                let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
                
                
                //Notification trigger
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                 
                //Create the request
                let request = UNNotificationRequest(identifier: "Alert", content: content, trigger: trigger)
                
                //Register the request
                center.add(request) { (error) in
                    
                }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Ask permission
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            
        }
}
}
