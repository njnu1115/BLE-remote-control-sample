//
//  UUID.swift
//  news
//
//  Created by Charlie Liu on 2022/7/11.
//

import Foundation
import CoreBluetooth

struct PeppleService {
    static let serviceUUID = CBUUID(string: "0000D132-0000-1000-8000-00805F9B34FB")
    static let characteristicUUID = CBUUID(string: "0000A2BE-0000-1000-8000-00805F9B34FB")
}
