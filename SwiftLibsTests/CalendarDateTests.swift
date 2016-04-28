
import XCTest
@testable import SwiftLibs

class CalendarDateTests: XCTestCase {

    func testConstructingACalendarDateWithADayMonthAndYearCreatesACalendarDateWithTheCorrectDateStringValue() {
        let subject = CalendarDate(day: 1, month: 5, year: 2016)
        
        let expectedDateString = "2016-05-01"
        
        XCTAssertEqual(subject.getDateString(), expectedDateString)
    }
    
    func testConstructingACalendarDateWithADayMonthAndYearCreatesACalendarDateWithTheCorrectDateValue() {
        let subject = CalendarDate(day: 1, month: 5, year: 2016)
        
        let dateString = "2016-05-01"
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let expectedDate = formatter.dateFromString(dateString)!
        
        XCTAssertEqual(subject.getNSDateValue(), expectedDate)
    }
}
