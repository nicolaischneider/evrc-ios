import Foundation

class UserDataAccess {
    
    static func saveEVRCData(_ data: [EVRCData]) {
        do {
            let jsonData = try JSONEncoder().encode(data)
            try StorageAccess.shared.setFile(jsonData)
            print("Data successfully saved.")
        } catch {
            print("Error saving data to file: \(error)")
        }
    }

    // Load history cycle data decrypted
    static func loadEVRCData() -> [EVRCData] {
        do {
            let data = try StorageAccess.shared.getFile()
            let decodedData = try JSONDecoder().decode([EVRCData].self, from: data)
            return decodedData
        } catch {
            print("Error loading data from file: \(error)")
            return []
        }
    }

    // Delete history cycle data file
    static func deleteEVRCData() {
        do {
            try StorageAccess.shared.removeFromFile()
            print("Data file successfully deleted.")
        } catch {
            print("Error deleting data file: \(error)")
        }
    }
}
