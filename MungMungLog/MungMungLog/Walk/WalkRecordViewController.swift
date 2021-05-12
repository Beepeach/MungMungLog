//
//  WalkRecordViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/05/12.
//

import UIKit
import MapKit
import CoreLocation

class WalkRecordViewController: UIViewController {
    
    var mainTimer: Timer?
    var timeCount = 0
    var pause = true
    var totalDistance: Double = 0.0

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var pauseAndStartButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
