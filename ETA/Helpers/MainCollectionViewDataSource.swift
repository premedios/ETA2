//
// Created by Pedro Remedios on 12/01/2018.
// Copyright (c) 2018 Pedro Remedios. All rights reserved.
//

import UIKit

class MainCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    var results = [Any]()
    var cellId = ""

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        guard let busNumberCollectionViewCell = cell as? BusNumberCollectionViewCell,
              let busObject = results[indexPath.row] as? [String: String],
              let busNumber = busObject["carreira"]  else { return cell }
        busNumberCollectionViewCell.viewModel = BusNumberViewModel(carreira: busNumber)
        return busNumberCollectionViewCell

    }
}
