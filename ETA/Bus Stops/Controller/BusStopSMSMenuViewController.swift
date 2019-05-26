//
//  BusStopSMSMenuViewController.swift
//  ETA
//
//  Created by Pedro Remedios on 26/05/2019.
//  Copyright © 2019 Pedro Remedios. All rights reserved.
//

import UIKit

class BusStopSMSMenuViewController: UIViewController {
    @IBOutlet var smsMenuTableView: UITableView?
    @IBOutlet var viewTopAnchor: NSLayoutConstraint?
    
    var coordinator: BusStopsCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
