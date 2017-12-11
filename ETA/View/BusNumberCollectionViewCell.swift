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
    
    var viewModel = BusNumberViewModel(carreira: "")
    
//    let view: UIView = {
//        let infoView = UIView()
//        infoView.backgroundColor = UIColor.AppColors.oceanBoatBlue
//        return infoView
//    }()
//
    let busNumberLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.linen
        label.font = UIFont(name: UIFont.Vision.bold, size: 40)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate func setupConstraints() {
//        view.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        busNumberLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, centerX: contentView.centerXAnchor, centerY: contentView.centerYAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setupUI() {
        //contentView.addSubview(view)
        contentView.backgroundColor = UIColor.AppColors.navyBlue
        contentView.addSubview(busNumberLabel)
        busNumberLabel.text = viewModel.carreira
//        let destinationStrings = getDestinations(forBusNumber: item!["carreira"]!).reduce("", {$0 + $1 + "\n"})
//        print(destinationStrings)
        setupConstraints()
    }
    
    private func getDestinations(forBusNumber: String) -> [String]  {
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = Bus.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "carreira = %@", viewModel.carreira)
        fetchRequest.propertiesToFetch = ["destino"]
        fetchRequest.returnsDistinctResults = true
        fetchRequest.resultType = .dictionaryResultType
            
        guard let destinationFetchRequestResult = try? CoreDataManager.sharedManager.mainContext.fetch(fetchRequest) else { return [String]() }
        
        var resultsArray = [String]()
        for item in destinationFetchRequestResult as! [NSDictionary] {
            guard let itemString = item["destino"] as? String else { return [String]() }
            resultsArray.append(String(itemString.utf8))
        }
        return resultsArray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
