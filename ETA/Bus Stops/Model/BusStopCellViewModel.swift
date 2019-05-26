//
//  BusStopViewModel.swift
//  ETA
//
//  Created by Pedro Remedios on 09/12/2017.
//  Copyright © 2017 Pedro Remedios. All rights reserved.
//

import Foundation

enum Interface: String {
    case aeroporto = "Aeroporto"
    case barco = "Barco"
    case comboio = "Comboio"
    case autocarro = "Autocarro"
    case metro = "Metro"
}

struct BusStopCellViewModel {
    var stopName: String
    var stopCode: String
    var interfaces: [Interface]

    init(with bus: Bus) {
        self.interfaces = [Interface]()
        self.stopName = bus.localizacao ?? ""
        self.stopCode = bus.codigo ?? ""
        if let interfaceContent = bus.interface, interfaceContent != "-" {
            let interfaces = interfaceContent.components(separatedBy: ";").map { (item) -> String in
                item.trimmingCharacters(in: .whitespaces)
            }

            if interfaces.count > 0 {
                interfaces.forEach { (value) in
                    self.interfaces.append(Interface(rawValue: value)!)
                }
            }
        }
    }
}
