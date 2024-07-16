import SwiftUI
import CoreBluetooth
import CoreImage.CIFilterBuiltins
import LocalAuthentication

enum VerificationState: Equatable {
    case idle
    case generatingQRCode
    case advertising(UIImage)
    case loading
    case complete
    case error

}

class VerificationFlowViewModel: NSObject, ObservableObject, CBPeripheralManagerDelegate {
    
    let eVRC: EVRCData
    @Published var state: VerificationState = .idle
    
    let uuid = UUID()
    let characteristicUUID = CBUUID(string: "0A2C8BFC-FC3E-4429-B51D-A66B361CC439")
    
    private var peripheralManager: CBPeripheralManager!
    
    init(eVRC: EVRCData) {
        self.eVRC = eVRC
        super.init()
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        transition(to: .generatingQRCode)
    }
    
    private func transition(to newState: VerificationState) {
        state = newState
        switch newState {
        case .idle:
            break
        case .generatingQRCode:
            generateQRCode()
        case .advertising:
            startAdvertising()
        case .loading:
            break
        case .complete:
            break
        case .error:
            break
        }
    }
    
    private func generateQRCode() {
        let connectionInfo = uuid.uuidString
        let data = Data(connectionInfo.utf8)
        let filter = CIFilter.qrCodeGenerator()
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage {
            let context = CIContext()
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                transition(to: .advertising(UIImage(cgImage: cgImage)))
            }
        }

        startAdvertising()
    }

    private func startAdvertising() {
        let serviceUUID = CBUUID(string: uuid.uuidString)
        let characteristicUUID = characteristicUUID
        let characteristic = CBMutableCharacteristic(
            type: characteristicUUID,
            properties: [.read, .write, .notify],
            value: nil,
            permissions: [.readable, .writeable])
        let service = CBMutableService(type: serviceUUID, primary: true)
        service.characteristics = [characteristic]
        peripheralManager.add(service)
        peripheralManager.startAdvertising([CBAdvertisementDataServiceUUIDsKey: [serviceUUID]])
        print("Started advertising with service UUID: \(serviceUUID)")
    }

    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        print("received request")
        state = .loading

        for request in requests {
            if let value = request.value, let message = String(data: value, encoding: .utf8), message == "START" {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.authenticateBiometric { success in
                        if success {
                            guard let data = try? self.eVRC.toVerifyData() else {
                                self.state = .error
                                return
                            }
                            print("sending response")
                            self.peripheralManager.updateValue(
                                data,
                                for: request.characteristic as! CBMutableCharacteristic,
                                onSubscribedCentrals: nil)
                            DispatchQueue.main.async {
                                self.transition(to: .complete)
                            }
                        } else {
                            self.state = .error
                            print("Biometric authentication failed")
                        }
                    }
                }
            }
        }
    }

    private func authenticateBiometric(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?

        // Check if biometric authentication is available on the device.
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Authenticate for sending data"

            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        completion(true)
                    } else {
                        // Error handling if needed
                        print("Authentication failed: \(authenticationError?.localizedDescription ?? "No error info")")
                        completion(false)
                    }
                }
            }
        } else {
            // No biometrics
            print("Biometric authentication not available: \(error?.localizedDescription ?? "No error info")")
            completion(false)
        }
    }

    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state != .poweredOn {
            print("Peripheral is not powered on")
        } else {
            print("Peripheral is powered on.")
            switch state {
            case .advertising(_):
                startAdvertising()
            default: break
            }
        }
    }
    
    func terminateConnection() {
        peripheralManager = nil
    }
}
