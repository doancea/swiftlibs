
import Foundation

public class CalendarDate: NSObject {
    
    private static let SECONDS_PER_DAY : Int32 = 60 * 60 * 24
    private static let MIDDAY_SECONDS_INTERVAL: Int32 = 60 * 60 * 12
    
    private let _stringValue: String
    private let _nsDateValue: NSDate
    private let _daysSince1970: NSInteger

    public init(day: Int, month: Int, year: Int) {
        self._stringValue = CalendarDate.calculateStringValue(day, month: month, year: year)
        self._nsDateValue = CalendarDate.calculateNSDateValue(day, month: month, year: year)
        self._daysSince1970 = CalendarDate.calculateDaysSince1970(self._nsDateValue)
    }
    
    public init(date: NSDate) {
        self._daysSince1970 = CalendarDate.calculateDaysSince1970(date)
        self._nsDateValue = CalendarDate.calculateNSDateValue(self._daysSince1970)

        self._stringValue = CalendarDate.calculateStringValue(_nsDateValue)
    }
    
    public init(daysInterval: NSInteger) {
        self._daysSince1970 = daysInterval
        self._nsDateValue = CalendarDate.calculateNSDateValue(daysInterval)
        self._stringValue = CalendarDate.calculateStringValue(_nsDateValue)
    }
    
    public func getDateString() -> String {
        return self._stringValue
    }

    public func getNSDateValue() -> NSDate {
        return self._nsDateValue
    }

    public func daysIntervalSince1970() -> NSInteger {
        return self._daysSince1970
    }

    private static func calculateStringValue(day: Int, month: Int, year: Int) -> String {
        let paddedDayString = String(format: "%02d", day)
        let paddedMonthString = String(format: "%02d", month)
        return "\(year)-\(paddedMonthString)-\(paddedDayString)"
    }

    private static func calculateStringValue(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.stringFromDate(date)
    }
    
    private static func calculateNSDateValue(day: Int, month: Int, year: Int) -> NSDate {
        let dateString = CalendarDate.calculateStringValue(day, month: month, year: year)
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.dateFromString(dateString)!
        let calendarDayTimeInterval: Double = date.timeIntervalSince1970 + Double(NSTimeZone.systemTimeZone().secondsFromGMT) + (12 * 60 * 60)
        
        return NSDate(timeIntervalSince1970: calendarDayTimeInterval)
    }
    
    private static func calculateNSDateValue(daysInterval: NSInteger) -> NSDate {
        let secondsInterval = Double(daysInterval) * Double(CalendarDate.SECONDS_PER_DAY) + Double(CalendarDate.MIDDAY_SECONDS_INTERVAL)
        
        let date  = NSDate(timeIntervalSince1970: secondsInterval)
        return date
    }
    
    private static func calculateNSDateValue(date: NSDate) -> NSDate {
        let daysInterval = CalendarDate.calculateDaysSince1970(date)
        
        return CalendarDate.calculateNSDateValue(daysInterval)
    }
    
    private static func calculateDaysSince1970(date: NSDate) -> NSInteger {
        
        let timeInt = Int32(date.timeIntervalSince1970) + NSTimeZone.systemTimeZone().secondsFromGMT
        return NSInteger((timeInt / CalendarDate.SECONDS_PER_DAY))
    }
}
