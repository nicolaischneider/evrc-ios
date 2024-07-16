import Foundation

class DateManager {
        
    enum DateFormat: String {
        case regularDate = "dd.MM.yy"
    }
    
    // Converts a Date to a String with a specified format
    static func convertDateToString(date: Date, format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.locale = Locale(identifier: "de_DE")
        return dateFormatter.string(from: date)
    }
    
    // Converts a String to a Date with a specified format
    static func convertStringToDate(dateString: String, format: DateFormat) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.locale = Locale(identifier: "de_DE")
        return dateFormatter.date(from: dateString)
    }
    
    static func daysBetweenDates(_ date1: Date, _ date2: Date) -> Int {
        let calendar = Calendar.current
        let startOfToday = calendar.startOfDay(for: date1)
        let startOfGivenDate = calendar.startOfDay(for: date2)
        
        let components = calendar.dateComponents([.day], from: startOfToday, to: startOfGivenDate)
        return (components.day ?? 0)
    }
}
