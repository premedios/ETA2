//
//  UIView+Utilites.swift
//  ETA
//
//  Created by Pedro Remedios on 05/12/2017.
//  Copyright © 2017 Pedro Remedios. All rights reserved.
//

import UIKit

extension UIView {

    func pinAnchor(top: (anchor: NSLayoutYAxisAnchor, constant: CGFloat)?,
                   leading: (anchor: NSLayoutXAxisAnchor, constant: CGFloat)?,
                   bottom: (anchor: NSLayoutYAxisAnchor, constant: CGFloat)?,
                   trailing: (anchor: NSLayoutXAxisAnchor, constant: CGFloat)?) {

        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top.anchor, constant: top.constant).isActive = true
        }

        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading.anchor, constant: leading.constant).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom.anchor, constant: -bottom.constant).isActive = true
        }

        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing.anchor, constant: -trailing.constant).isActive = true
        }
    }

    func centerAnchor(centerX: (anchor: NSLayoutXAxisAnchor, constant: CGFloat)?,
                      centerY: (anchor: NSLayoutYAxisAnchor, constant: CGFloat)?) {

        translatesAutoresizingMaskIntoConstraints = false

        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX.anchor, constant: centerX.constant).isActive = true
        }

        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY.anchor, constant: centerY.constant).isActive = true
        }
    }

    func sizeAnchor(width: CGFloat, height: CGFloat) {
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
