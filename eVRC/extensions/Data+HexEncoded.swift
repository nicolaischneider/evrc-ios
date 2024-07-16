import Foundation

extension Data {

   public init?(hexString: String) {
        let len = hexString.count / 2
        var data = Data(capacity: len)

        for iCounter in 0 ..< len {
            let jCounter = hexString.index(hexString.startIndex, offsetBy: iCounter * 2)
            let kCounter = hexString.index(jCounter, offsetBy: 2)
            let bytes = hexString[jCounter ..< kCounter]
            if var num = UInt8(bytes, radix: 16) {
                data.append(&num, count: 1)
            } else {
                return nil
            }
        }
        self = data
    }

    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
        
        init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }

    func hexEncodedString() -> String {
        hexEncodedString(options: [])
    }
    
    func hexEncodedString(options: HexEncodingOptions) -> String {
        let hexDigits = Array((options.contains(.upperCase) ? "0123456789ABCDEF" : "0123456789abcdef").utf16)
        var chars: [unichar] = []
        chars.reserveCapacity(2 * count)
        for byte in self {
            chars.append(hexDigits[Int(byte / 16)])
            chars.append(hexDigits[Int(byte % 16)])
        }
        return String(utf16CodeUnits: chars, count: chars.count)
    }

}
