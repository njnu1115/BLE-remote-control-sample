/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Transfer service and characteristics UUIDs
*/

import Foundation
import CoreBluetooth

struct TransferService {
    static let serviceUUID = CBUUID(string: "701FD132-DE43-4051-B3B1-D8BE1479001B")
    static let characteristicUUID = CBUUID(string: "CCE8A2BE-4769-464F-924B-D6092DD31D4D")
}
