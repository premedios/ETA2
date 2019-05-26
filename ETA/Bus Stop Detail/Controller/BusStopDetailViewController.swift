//
//  BusStopDetailViewController.swift
//  ETA
//
//  Created by Pedro Remedios on 18/01/2019.
//  Copyright © 2019 Pedro Remedios. All rights reserved.
//

import UIKit
import FontAwesome

class BusStopDetailViewController: UIViewController, Storyboarded {

    @IBOutlet weak var smsCodeTitleLabel: UILabel!
    @IBOutlet weak var smsCodeLabel: UILabel!
    @IBOutlet weak var interfacesTitleLabel: UILabel!
    @IBOutlet weak var interfacesCollectionView: UICollectionView!
    @IBOutlet weak var destinationLabel: UILabel!

    @IBOutlet weak var interfacesWidth: NSLayoutConstraint!

    let titleLabel = BusStopDetailTitleView(frame: .zero)

    var interfacesDatasource: InterfacesDatasource?
    var interfacesDelegate: InterfacesDelegate?

    private var viewModel: BusStopDetailViewModel!

    weak var object: Bus? {
        didSet {
            self.viewModel = BusStopDetailViewModel(object: object!)
            self.busStopName = viewModel.name
            self.interfacesDatasource = InterfacesDatasource(with: viewModel)
            self.interfacesDelegate = InterfacesDelegate(with: viewModel.numberOfCells)

        }
    }

    var busStopName: String? {
        didSet {
            titleLabel.text = busStopName
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        smsCodeTitleLabel.text = NSLocalizedString("SMS Code", comment: "")
        smsCodeLabel.text = viewModel.code

        if viewModel.numberOfCells.count > 0 {
            self.interfacesWidth.constant = CGFloat(viewModel.numberOfCells[0] * 70)
        }
        self.interfacesCollectionView.delegate = self.interfacesDelegate
        self.interfacesCollectionView.dataSource = self.interfacesDatasource

        self.destinationLabel.text = viewModel.destination

        navigationItem.titleView = titleLabel
        navigationItem.titleView?.heightAnchor.constraint(equalToConstant: 100)
        navigationController?.navigationBar.setNeedsLayout()

        let smsBarButtonItem = UIBarButtonItem(title: String.fontAwesomeIcon(name: .sms), style: .plain, target: nil, action: #selector(showSMSToSend))
        let smsButtonTextAttributes = [
            NSAttributedString.Key.font: UIFont.fontAwesome(ofSize: 30, style: .solid)
        ]
        smsBarButtonItem.setTitleTextAttributes(smsButtonTextAttributes, for: .normal)
        navigationItem.rightBarButtonItem = smsBarButtonItem
    }

    @objc func showSMSToSend(sender: UIBarButtonItem) {

    }
}
