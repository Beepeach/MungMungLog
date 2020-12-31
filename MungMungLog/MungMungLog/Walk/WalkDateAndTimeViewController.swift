//
//  WalkingDateAndTimeViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/12/30.
//

import UIKit

class WalkDateAndTimeViewController: UIViewController {
    
    @IBOutlet weak var walkDatePicker: UIDatePicker!
    @IBOutlet weak var walkTimePicker: UIDatePicker!
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        let walkDate = self.koreaDateFormatter.string(from: walkDatePicker.date)
        let walkTime = self.koreaTimeFormatter.string(from: walkTimePicker.date)
        
        let walkDateAndTime = [walkDate, walkTime]
        
        NotificationCenter.default.post(name: NSNotification.Name.DateValueDidChange, object: nil, userInfo: ["WalkDateAndTime": walkDateAndTime])
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}


extension NSNotification.Name {
    static let DateValueDidChange = NSNotification.Name("DateValueDidChangeNotification")
}
