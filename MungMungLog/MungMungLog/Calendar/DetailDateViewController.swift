//
//  DetailDateViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/07/15.
//

import UIKit

class DetailDateViewController: UIViewController {
    private var date: Date?

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = date?.koreanDateFormatted
    }
    
    public func setDate(date: Date) {
        self.date = date
    }
}
