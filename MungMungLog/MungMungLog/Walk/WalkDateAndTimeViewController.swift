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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let walkRecordEditingVC = segue.destination as? WalkRecordEditingViewController else { return }
        
        walkRecordEditingVC.walkDateAndTimeLabel.text = """
            \(self.koreaDateFormatter.string(from: walkDatePicker.date))
            \(self.koreaTimeFormatter.string(from: walkTimePicker.date))
            """
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
