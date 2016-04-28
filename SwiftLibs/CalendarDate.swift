
import Foundation

public class CalendarDate: NSObject {
    
    private let _day: Int
    private let _month: Int
    private let _year: Int
    private let _stringValue: String
    private let _nsDateValue: NSDate

    public init(day: Int, month: Int, year: Int) {
        self._day = day
        self._month = month
        self._year = year
        
        self._stringValue = CalendarDate.calculateStringValue(day, month: month, year: year)
        self._nsDateValue = CalendarDate.calculateNSDateValue(day, month: month, year: year)
    }
    
    public func getDateString() -> String {
        return self._stringValue
    }
    
    public func getNSDateValue() -> NSDate {
        return self._nsDateValue
    }
    
    private static func calculateStringValue(day: Int, month: Int, year: Int) -> String {
        let paddedDayString = String(format: "%02d", day)
        let paddedMonthString = String(format: "%02d", month)
        return "\(year)-\(paddedMonthString)-\(paddedDayString)"
    }
    
    private static func calculateNSDateValue(day: Int, month: Int, year: Int) -> NSDate {
        let dateString = CalendarDate.calculateStringValue(day, month: month, year: year)
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.dateFromString(dateString)!
    }
}
