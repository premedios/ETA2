//
//  BusNumberCollectionViewCell.swift
//  ETA
//
//  Created by Pedro Remedios on 28/04/2017.
//  Copyright © 2017 Pedro Remedios. All rights reserved.
//

import UIKit
import CoreData

class BusNumberCollectionViewCell: UICollectionViewCell {

    var viewModel: BusNumberViewModel! {
        didSet {
            busNumberLabel.labelText = viewModel.carreira
        }
    }
    
    let busNumberLabel = BusNumberLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = UIColor.AppColors.navyBlue
        contentView.addSubview(busNumberLabel)
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BusNumberCollectionViewCell {
    fileprivate func setupConstraints() {
        busNumberLabel.pinAnchor(top: (anchor: contentView.topAnchor, constant: 0),
                                 leading: (anchor: contentView.leadingAnchor, constant: 0),
                                 bottom: (anchor: contentView.bottomAnchor, constant: 0),
                                 trailing: (anchor: contentView.trailingAnchor, constant: 0))
        busNumberLabel.centerAnchor(centerX: (anchor: contentView.centerXAnchor, constant: 0),
                                    centerY: (anchor: contentView.centerYAnchor, constant: 0))
    }
    
    //    private func getDestinations(forBusNumber: String) -> [String]  {
    //        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = Bus.fetchRequest()
    //        fetchRequest.predicate = NSPredicate(format: "carreira = %@", viewModel.carreira)
    //        fetchRequest.propertiesToFetch = ["destino"]
    //        fetchRequest.returnsDistinctResults = true
    //        fetchRequest.resultType = .dictionaryResultType
    //
    //        guard let destinationFetchRequestResult =
    //    try? CoreDataManager.sharedManager.mainContext.fetch(fetchRequest) else { return [String]() }
    //
    //        var resultsArray = [String]()
    //        for item in destinationFetchRequestResult as! [NSDictionary] {
    //            guard let itemString = item["destino"] as? String else { return [String]() }
    //            resultsArray.append(String(itemString.utf8))
    //        }
    //        return resultsArray
    //    }

}
