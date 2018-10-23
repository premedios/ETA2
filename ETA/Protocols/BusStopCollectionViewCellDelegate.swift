//
//  BusStopCollectionViewCellDelegate.swift
//  ETA
//
//  Created by Pedro Remedios on 02/06/2018.
//  Copyright © 2018 Pedro Remedios. All rights reserved.
//

import Foundation
import UIKit

protocol BusStopCollectionViewCellDelegate {
    func collectionView(_ collectionView: UICollectionView, didChangeFavouriteStateForCellAt indexPath: IndexPath)
}
