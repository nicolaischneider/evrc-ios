import Foundation

struct SharedInstance: Codable, Equatable, Identifiable {
    var id = UUID()
    var nickname: String
    var validity: Validity?
}
