import Foundation

struct Validity: Codable, Equatable {
    var validFrom: Date
    var validUntil: Date
}

struct EVRCData: Codable, Identifiable, Equatable {
    
    var id = UUID()
    
    var licensePlateNumber: String
    var brand: String
    var vehicleType: String
    var vehicleIdentificationNumber: String
    var vehicleOwnerName: String
    var vehicleOwnerFirstnames: String
    var vehicleOwnerAddress: String
    var vehicleCategory: String
    var issueDate: String
    var issuingCountry: String
    var issuingAuthority: String
    
    var validity: Validity?
    
    var isSharedInstance: Bool
    var sharedInstances: [SharedInstance]
    
    init(id: UUID = UUID(), licensePlateNumber: String, brand: String, vehicleType: String, vehicleIdentificationNumber: String, vehicleOwnerName: String, vehicleOwnerFirstnames: String, vehicleOwnerAddress: String, vehicleCategory: String, issueDate: String, issuingCountry: String, issuingAuthority: String, isSharedInstance: Bool, sharedInstances: [SharedInstance], validity: Validity?) {
        self.id = id
        self.licensePlateNumber = licensePlateNumber
        self.brand = brand
        self.vehicleType = vehicleType
        self.vehicleIdentificationNumber = vehicleIdentificationNumber
        self.vehicleOwnerName = vehicleOwnerName
        self.vehicleOwnerFirstnames = vehicleOwnerFirstnames
        self.vehicleOwnerAddress = vehicleOwnerAddress
        self.vehicleCategory = vehicleCategory
        self.issueDate = issueDate
        self.issuingCountry = issuingCountry
        self.issuingAuthority = issuingAuthority
        self.validity = validity
        self.isSharedInstance = isSharedInstance
        self.sharedInstances = sharedInstances
    }
    
    func valuesAsArray() -> [(String, String)] {
        return [
            ("evrc.license.plate".localized, licensePlateNumber),
            ("evrc.brand".localized, brand),
            ("evrc.vehicle.type".localized, vehicleType),
            ("evrc.vehicle.identification.number".localized, vehicleIdentificationNumber),
            ("evrc.vehicle.owner.name".localized, vehicleOwnerName),
            ("evrc.vehicle.owner.firstnames".localized, vehicleOwnerFirstnames),
            ("evrc.vehicle.owner.address".localized, vehicleOwnerAddress),
            ("evrc.vehicle.category".localized, vehicleCategory),
            ("evrc.issue.date".localized, issueDate),
            ("evrc.issuing.country".localized, issuingCountry),
            ("evrc.issuing.authority".localized, issuingAuthority)
        ]
    }
}

extension EVRCData {
    
    func toVerifyData() throws -> Data {
        let encoder = JSONEncoder()
        var newValue = self
        newValue.sharedInstances = []
        return try encoder.encode(newValue)
    }
    
    func toJSONForIssuing() throws -> String {
        let encoder = JSONEncoder()
        var newValue = self
        newValue.sharedInstances = []
        let encoded = try encoder.encode(newValue)
        return encoded.hexEncodedString()
    }
    
    func toJSONForSharing(validity: Validity?) throws -> String {
        let encoder = JSONEncoder()
        var newValue = self
        newValue.sharedInstances = []
        newValue.isSharedInstance = true
        newValue.validity = validity
        let encoded = try encoder.encode(newValue)
        return encoded.hexEncodedString()
    }
    
    static func fromJSON(hexString: String) -> EVRCData? {
        guard let data = Data(hexString: hexString) else {
            print("Error: Unable to convert hex string to Data")
            return nil
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(EVRCData.self, from: data)
        } catch {
            print("Failed to decode EVRCData from JSON: \(error)")
            return nil
        }
    }
}
