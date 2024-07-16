import Foundation

extension String {
    var alphanumericUppercased: String {
        self.filter { $0.isLetter || $0.isNumber }
            .uppercased()
    }
}
