import Foundation

enum IssuingError {
    case wrongQRCode
    case general
    case wrongLicensePlateNumber
    case authFailed
    case alreadyIssued
    
    var localizedText: String {
        switch self {
        case .wrongQRCode:
            return "issuing.error.wrongqrcode".localized
        case .general:
            return "issuing.error.general".localized
        case .wrongLicensePlateNumber:
            return "issuing.error.wrongelicenseplatenumber".localized
        case .authFailed:
            return "issuing.error.auth.failed".localized
        case .alreadyIssued:
            return "issuing.error.already.issued".localized
        }
    }
}
