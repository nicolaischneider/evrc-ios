import SwiftUI

class IssuingViewModel: ObservableObject {
    
    enum IssuingState {
        case scanQR
        case enterLicensePlateNumber
        case confirmFaceIDusage
        case downloadEVRC
        case successflDownload(EVRCData)
        case error(IssuingError)
        
        var quitButtonAvailable: Bool {
            switch self {
            case .successflDownload, .error:
                return false
            default:
                return true
            }
        }
        
        var backButtonAvailable: Bool {
            switch self {
            case .enterLicensePlateNumber, .confirmFaceIDusage:
                return true
            default:
                return false
            }
        }
    }
    
    @Published var state: IssuingState = .scanQR
    
    @Binding var vehicles: [EVRCData]
    
    private var eVRCData: EVRCData?
    private var enteredLicensePlateNumber: String?
    
    init(vehicles: Binding<[EVRCData]>) {
        _vehicles = vehicles
    }
    
    func scannedQRCode(_ qrCode: String) {
        guard let decodedData = EVRCData.fromJSON(hexString: qrCode) else {
            state = .error(.wrongQRCode)
            return
        }
        self.eVRCData = decodedData
        state = .enterLicensePlateNumber
    }
    
    func enteredLicensePlateNumber(_ enteredValue: String) {
        self.enteredLicensePlateNumber = enteredValue
        state = .confirmFaceIDusage
    }
    
    func acceptedUsageOfFaceID() {
        state = .downloadEVRC
    }
    
    func userFinishedAuthenticating(_ verified: Bool) {
        if verified {
            guard let eVRCData, let enteredLicensePlateNumber else {
                errorOccurred(.general)
                return
            }
            
            guard
                eVRCData.licensePlateNumber.alphanumericUppercased
                    == enteredLicensePlateNumber.alphanumericUppercased else {
                errorOccurred(.wrongLicensePlateNumber)
                return
            }
            
            eVRCHasBeenInstalled()
        } else {
            errorOccurred(.authFailed)
        }
    }
    
    func eVRCHasBeenInstalled() {
        guard let eVRCData else {
            errorOccurred(.general)
            return
        }
        guard !vehicles.contains(eVRCData) else {
            errorOccurred(.alreadyIssued)
            return
        }
        
        vehicles.append(eVRCData)
        state = .successflDownload(eVRCData)
    }
    
    func errorOccurred(_ error: IssuingError) {
        state = .error(error)
    }
}
