import SwiftUI

class UpdateViewModel: ObservableObject {
    
    enum UpdateState {
        case noUpdate
        case updateOneVehicle(EVRCData)
        case updateMultipleVehicles([EVRCData])
        case updating
        case verified
        case error(String)
    }
    
    @Published var state: UpdateState
    
    init(state: UpdateState) {
        self.state = state
    }
    
    func didUpdate(_ updated: Bool) {
        if updated {
            state = .verified
        } else {
            state = .error("issuing.error.general".localized)
        }
    }
    
    func userRequestedUpdate() {
        state = .updating
    }
}
