//
//  ViewController.swift
//  FCMRemoteNotification
//
//  Created by HoangLuyen on 8/29/18.
//  Copyright © 2018 HoangLuyen. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var fcmMessage: UILabel!
    @IBOutlet weak var instanceIDToken: UILabel!
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(displayFCMToken(notification:)), name: Notification.Name("FCMToken"), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func handlerLogToken(_ sender: UIButton) {
        // [START log_fcm_reg_token]
        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")
        // [END log_fcm_reg_token]
        fcmMessage.text = "Logged FCM token: \(token ?? "")"
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
                self.instanceIDToken.text  = "Remote InstanceID token: \(result.token)"
            }
        }
        // [END log_iid_reg_token]
    }
    @IBAction func handleSubscribe(_ sender: UIButton) {
        // [START subscribe_topic]
        Messaging.messaging().subscribe(toTopic: "news") { error in
            print("Subscribed to news topic")
        }
        // [END subscribe_topic]
    }
    @objc func displayFCMToken(notification: Notification)  {
        guard let userInfo = notification.userInfo else { return }
        if let fcmToken = userInfo["token"] as? String {
            fcmMessage.text = "Received FCM Token: \(fcmToken)"
        }
    }
}

