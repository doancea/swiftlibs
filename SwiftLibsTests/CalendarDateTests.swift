
import XCTest
@testable import SwiftLibs

class CalendarDateTests: XCTestCase {

    func testConstructingACalendarDateWithADayMonthAndYearCreatesACalendarDateWithTheCorrectDateStringValue() {
        let subject = CalendarDate(day: 1, month: 5, year: 2016)
        
        let expectedDateString = "2016-05-01"
        
        XCTAssertEqual(subject.getDateString(), expectedDateString)
    }
    
    func testConstructingACalendarDateWithADayMonthAndYearCreatesACalendarDateWithTheCorrectNumericalValue() {
        let simpleToVerifyDate = CalendarDate(day: 2, month: 1, year: 1970)
        let difficultToVerifyDate = CalendarDate(day: 20, month: 4, year: 2016)
        
        let expectedSimpleDayValue: NSNumber = 1
        XCTAssertEqual(simpleToVerifyDate.daysIntervalSince1970(), expectedSimpleDayValue)
        
        let expectedDifficultDayValue: NSNumber = 16911
        XCTAssertEqual(difficultToVerifyDate.daysIntervalSince1970(), expectedDifficultDayValue)
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
