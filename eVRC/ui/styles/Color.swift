import SwiftUI

extension Color {
    
    // main views backgrounds
    static let headerGray = Color(hex: "D9D9D9")
    static let systemGray = Color(.systemGroupedBackground)
    
    // blue
    static let blueDark = Color(hex: "007AFF")
    static let blueLight = Color(hex: "007AFF", opacity: 0.25)
    static let blueVeryLight = Color(hex: "007AFF", opacity: 0.1)
    
    // red
    static let redDark = Color(hex: "D00000")
    static let redLight = Color(hex: "FFD3C0")
    
    // pink
    static let pinkShare = Color(hex: "BD00FF")
}

extension Color {
    
    init(hex: String, opacity: Double = 1) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff,
            opacity: opacity
        )
    }
}
