//
//  BusStopsDelegate.swift
//  ETA
//
//  Created by Pedro Remedios on 10/02/2019.
//  Copyright © 2019 Pedro Remedios. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class BusStopsDelegate: NSObject, UITableViewDelegate {
    var coordinator: BusStopsCoordinator?

    var dataSource: BusStopsDatasource

    private var reuseID = String(describing: BusStopsSectionHeader.self)

    init(with dataSource: BusStopsDatasource) {
        self.dataSource = dataSource
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseID)
        guard let headerView = view as? BusStopsSectionHeader else { return nil }
        guard let sections = dataSource.fetchedResultsController.sections
            else { return nil }
        headerView.sectionName = sections[section].name
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 58
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let object = dataSource.fetchedResultsController.object(at: indexPath)
        let viewModel = BusStopCellViewModel(with: object)
        return UITableView.automaticDimension
//        if viewModel.interfaces.count > 0 {
//            return 55
//        } else {
//            return UITableView.automaticDimension
//        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
