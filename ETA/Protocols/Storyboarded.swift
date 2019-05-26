//
//  Storyboarded.swift
//  ETA
//
//  Created by Pedro Remedios on 05/02/2019.
//  Copyright © 2019 Pedro Remedios. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let viewControllerId = String(describing: self)
        let storyboard = UIStoryboard(name: "ETA", bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerId) as? Self
            else { fatalError("Instantiating view controller from storyboard") }
        return viewController
    }
}
