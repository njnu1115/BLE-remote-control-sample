/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Transfer service and characteristics UUIDs
*/

import Foundation
import CoreBluetooth

struct TransferService {
    static let serviceUUID = CBUUID(string: "0000D132-0000-1000-8000-00805F9B34FB")
    static let characteristicUUID = CBUUID(string: "0000A2BE-0000-1000-8000-00805F9B34FB")
}
