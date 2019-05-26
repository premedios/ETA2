//
//  BusStopDetailViewModel.swift
//  ETA
//
//  Created by Pedro Remedios on 20/02/2019.
//  Copyright © 2019 Pedro Remedios. All rights reserved.
//

import Foundation

enum Interface: String {
    case aeroporto = "Aeroporto"
    case barco = "Barco"
    case comboio = "Comboio"
    case autocarro = "Autocarro"
    case metro = "Metro"
}

class BusStopDetailViewModel {
    var name: String
    var code: String
    var destination: String
    var interfaces = [Interface]()
    var numberOfCells = [Int]()
    var noInterfaces: String

    init(object: Bus) {
        self.name = object.localizacao ?? ""
        self.code = object.codigo ?? ""
        self.destination = object.destino ?? ""
        self.noInterfaces = NSLocalizedString("None", comment: "")
        if let interfaceContent = object.interface, interfaceContent != "-" {
            let interfaces = interfaceContent.components(separatedBy: ";").map { (item) -> String in
                item.trimmingCharacters(in: .whitespaces)
            }

            if interfaces.count > 0 {
                self.noInterfaces = ""
                interfaces.forEach { (value) in
                    self.interfaces.append(Interface(rawValue: value)!)
                }
                numberOfCells.append((interfaces.count <= 2 ? interfaces.count : Int(ceil(Float(interfaces.count) / 2.0))))
                if numberOfCells[0] != interfaces.count {
                    numberOfCells.append(interfaces.count - numberOfCells[0])
                }
            }
        }
    }
}
