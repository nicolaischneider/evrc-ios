import Foundation
import CryptoKit

class StorageAccess {
    
    enum StorageError: Error {
        case dataFileURLNotLoaded
    }
    
    static let shared = StorageAccess()
    
    var url: URL? {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return documentsDirectory.appendingPathComponent("IssuedVehicles.bin")
    }
    
    // MARK: - Storage File
    func setFile(_ data: Data) throws {
        guard let url else {
            throw StorageError.dataFileURLNotLoaded
        }
        try data.write(to: url)
    }
    
    func getFile() throws -> Data {
        guard let url else {
            throw StorageError.dataFileURLNotLoaded
        }
        return try Data(contentsOf: url)
    }
    
    func removeFromFile() throws {
        guard let url else {
            throw StorageError.dataFileURLNotLoaded
        }
        try FileManager.default.removeItem(at: url)
    }
}
