//
//  BusStopsSectionHeaderReusableView.swift
//  ETA
//
//  Created by Pedro Remedios on 10/12/2017.
//  Copyright © 2017 Pedro Remedios. All rights reserved.
//

import UIKit

class BusStopsSectionHeaderReusableView: UICollectionReusableView {
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.navyBlue
        return view
    }()

    private let sectionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.linen
        label.font = UIFont(name: UIFont.Vision.heavy, size: 20)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(withTitle sectionTitle: String) {

        sectionLabel.text = sectionTitle

        addSubview(backgroundView)
        backgroundView.addSubview(sectionLabel)

        backgroundView.pinAnchor(top: (anchor: topAnchor, constant: 4),
                                 leading: (anchor: leadingAnchor, constant: 4),
                                 bottom: (anchor: bottomAnchor, constant: 4),
                                 trailing: (anchor: trailingAnchor, constant: 4))

        sectionLabel.pinAnchor(top: nil,
                               leading: (anchor: backgroundView.leadingAnchor, constant: 8),
                               bottom: nil,
                               trailing: nil)
        sectionLabel.centerAnchor(centerX: nil,
                                  centerY: (anchor: backgroundView.centerYAnchor, constant: 0))
    }
}
