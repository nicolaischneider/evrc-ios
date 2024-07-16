import SwiftUI

class SharingViewModel: ObservableObject {
    
    enum SharingState {
        case onboardingView
        case enterNicknameView
        case enterValidity
        case retrieveQRCode
        case qrCodeView(String)
        case error(String)
        
        var quitButtonAvailable: Bool {
            switch self {
            case .qrCodeView, .error:
                return false
            default:
                return true
            }
        }
        
        var backButtonAvailable: Bool {
            switch self {
            case .enterNicknameView, .enterValidity:
                return true
            default:
                return false
            }
        }
    }
    
    @Published var state: SharingState = .onboardingView
    
    @Binding var vehicle: EVRCData
    
    var nickname: String?
    var validity: Validity?
        
    init(vehicle: Binding<EVRCData>) {
        _vehicle = vehicle
    }
    
    func proceedToEnterNickname() {
        state = .enterNicknameView
    }
    
    func enteredNickname(_ name: String) {
        self.nickname = name
        state = .enterValidity
    }
    
    func enteredValidity(_ validity: Validity?) {
        self.validity = validity
        state = .retrieveQRCode
    }
    
    func userFinishedAuthenticating(_ verified: Bool) {
        if verified {
            qrCodeHasBeenRetrieved()
        } else {
            state = .error("Authentication failed")
        }
    }
    
    func qrCodeHasBeenRetrieved() {
        guard let qrCode = try? vehicle.toJSONForSharing(validity: validity) else {
            state = .error("Something went wrong while fetching the QR-Code")
            return
        }
        
        vehicle.sharedInstances.append(
            SharedInstance(
                nickname: nickname ?? "Some Name",
                validity: validity))
        
        state = .qrCodeView(qrCode)
    }
}
