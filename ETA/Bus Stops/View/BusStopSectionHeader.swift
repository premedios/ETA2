//
//  ETASectionHeaderReusableView.swift
//  ETA
//
//  Created by Pedro Remedios on 21/06/2018.
//  Copyright © 2018 Pedro Remedios. All rights reserved.
//

import UIKit

class BusStopsSectionHeader: UITableViewHeaderFooterView {

    var sectionNameLabel: UILabel!

    private var headerBackground: UIView!

    var sectionName: String? {
        didSet {
            sectionNameLabel.text = sectionName
        }
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        headerBackground = UIView()
        headerBackground.backgroundColor = UIColor(named: "Navy Blue")
        headerBackground.translatesAutoresizingMaskIntoConstraints = false
        sectionNameLabel = UILabel()
        sectionNameLabel.translatesAutoresizingMaskIntoConstraints = false
        sectionNameLabel.textColor = UIColor(named: "Linen")
        sectionNameLabel.font = UIFont(name: UIFont.Vision.bold, size: 22)
        headerBackground.addSubview(sectionNameLabel)
        contentView.addSubview(headerBackground)

        headerBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1).isActive = true
        headerBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        headerBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        headerBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1).isActive = true
        sectionNameLabel.topAnchor.constraint(equalTo: headerBackground.topAnchor).isActive = true
        sectionNameLabel.leadingAnchor.constraint(equalTo: headerBackground.leadingAnchor, constant: 8).isActive = true
        sectionNameLabel.bottomAnchor.constraint(equalTo: headerBackground.bottomAnchor).isActive = true
        sectionNameLabel.trailingAnchor.constraint(equalTo: headerBackground.trailingAnchor, constant: -8).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
