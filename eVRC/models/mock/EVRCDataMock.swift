import Foundation

enum EVRCDataMock {
    
    static let example1 = EVRCData(
        licensePlateNumber: "AB CD 123",
        brand: "Tesla",
        vehicleType: "Model S",
        vehicleIdentificationNumber: "5YJSA1DN5DFP14795",
        vehicleOwnerName: "Doe, John",
        vehicleOwnerFirstnames: "John Michael",
        vehicleOwnerAddress: "4567 Maple Avenue, Anytown, CA 12345",
        vehicleCategory: "M1",
        issueDate: "2023-01-15",
        issuingCountry: "USA",
        issuingAuthority: "Department of Motor Vehicles",
        isSharedInstance: false,
        sharedInstances: [SharedInstance(nickname: "Steve Jobs")],
        validity: nil
    )
    
    static let example2 = EVRCData(
        licensePlateNumber: "EF GH 123",
        brand: "BMW",
        vehicleType: "Coupe",
        vehicleIdentificationNumber: "WBA1J7C53EVW47360",
        vehicleOwnerName: "Smith, Alice",
        vehicleOwnerFirstnames: "Alice Maria",
        vehicleOwnerAddress: "7890 Cherry Lane, Newville, NY 45678",
        vehicleCategory: "M1",
        issueDate: "2022-08-24",
        issuingCountry: "Germany",
        issuingAuthority: "Kraftfahrt-Bundesamt",
        isSharedInstance: false,
        sharedInstances: [],
        validity: nil
    )
    
    static let example3 = EVRCData(
        licensePlateNumber: "B DR 123",
        brand: "Mercedes-Benz",
        vehicleType: "S 500 4MATIC Lang",
        vehicleIdentificationNumber: "WDDUG8DB5JA403957",
        vehicleOwnerName: "Schneider, Peter",
        vehicleOwnerFirstnames: "Peter Klaus",
        vehicleOwnerAddress: "Beispielweg 42, 10115 Berlin, Deutschland",
        vehicleCategory: "M1",
        issueDate: "2023-07-10",
        issuingCountry: "DE",
        issuingAuthority: "Kraftfahrt-Bundesamt",
        isSharedInstance: false,
        sharedInstances: [],
        validity: nil
    )
    
    static let exampleShared = EVRCData(
        licensePlateNumber: "EF GH 123",
        brand: "BMW",
        vehicleType: "Coupe",
        vehicleIdentificationNumber: "WBA1J7C53EVW47360",
        vehicleOwnerName: "Smith, Alice",
        vehicleOwnerFirstnames: "Alice Maria",
        vehicleOwnerAddress: "7890 Cherry Lane, Newville, NY 45678",
        vehicleCategory: "M1",
        issueDate: "2022-08-24",
        issuingCountry: "Germany",
        issuingAuthority: "Kraftfahrt-Bundesamt",
        isSharedInstance: true,
        sharedInstances: [],
        validity: Validity(validFrom: Date(), validUntil: Date())
    )
}
