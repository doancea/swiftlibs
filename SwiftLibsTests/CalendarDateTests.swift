
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

    func testConstructingACalendarDateWithADayMonthAndYearCreatesACalendarDateWithTheCorrectDateValueAndTheTimeIsNoonForTheCurrentSystemTimeZone() {
        let subject = CalendarDate(day: 1, month: 5, year: 2016)

        let dateString = "2016-05-01"
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        let timeValue: NSTimeInterval = formatter.dateFromString(dateString)!.timeIntervalSince1970 + Double(NSTimeZone.systemTimeZone().secondsFromGMT) + (60 * 60 * 12)
        let expectedDateWithNoonTime = NSDate(timeIntervalSince1970: timeValue)
        XCTAssertEqual(subject.getNSDateValue(), expectedDateWithNoonTime)
    }
    
    func testConstructingACalendarDateWithAnNSDateValueCreatesACalendarDateWithADateValueOfNoonOnTheDayGiven() {
        let dateString = "2014-04-23 23:59"
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let givenDateWithArbitraryTime = formatter.dateFromString(dateString)!
        
        let subject = CalendarDate(date: givenDateWithArbitraryTime)
        
        let dateStringWithNoTime = "2014-04-23"
        formatter.dateFormat = "yyyy-MM-dd"
        let expectedDateTimeInterval = formatter.dateFromString(dateStringWithNoTime)!.timeIntervalSince1970 + Double(NSTimeZone.systemTimeZone().secondsFromGMT) + (60 * 60 * 12)
        let expectedDateValue = NSDate(timeIntervalSince1970: expectedDateTimeInterval)
        
        XCTAssertEqual(subject.getNSDateValue(), expectedDateValue)
    }
    
    func testConstructingACalendarDateWithAnNSDateValueCreatesACalendarDateWithTheCorrectDaysInterval() {
        let dateString = "2016-04-20 03:59"
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let givenDateWithArbitraryTime = formatter.dateFromString(dateString)!
        
        let subject = CalendarDate(date: givenDateWithArbitraryTime)
        
        let expectedDaysInterval = 16911
        XCTAssertEqual(subject.daysIntervalSince1970(), expectedDaysInterval)
    }
    
    func testConstructingACalendarDateWithAnNSDateValueCreatesACalendarDateWithTheCorrectDateString() {
        let dateString = "2014-10-23 23:59"
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let givenDateWithArbitraryTime = formatter.dateFromString(dateString)!
        
        let subject = CalendarDate(date: givenDateWithArbitraryTime)
        
        let expectedDateString = "2014-10-23"
        
        XCTAssertEqual(subject.getDateString(), expectedDateString)
    }
    
    func testConstructingACalendarDateWithAnIntValueCreatesACalendarDateWithTheCorrectIntValue() {
        let givenIntValue: NSInteger = 16911
        
        let subject = CalendarDate(daysInterval: givenIntValue)
        
        XCTAssertEqual(subject.daysIntervalSince1970(), givenIntValue)
    }
    
    func testConstructingACalendarDateWithAnIntValueCreatesACalendarDateWithTheCorrecNSDateValue() {
        let givenIntValue: NSInteger = 16911
        
        let subject = CalendarDate(daysInterval: givenIntValue)
        
        let dateStringWithNoTime = "2016-04-20"
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let expectedDateTimeInterval = formatter.dateFromString(dateStringWithNoTime)!.timeIntervalSince1970 + Double(NSTimeZone.systemTimeZone().secondsFromGMT) + (60 * 60 * 12)
        let expectedDateValue = NSDate(timeIntervalSince1970: expectedDateTimeInterval)

        
        XCTAssertEqual(subject.getNSDateValue(), expectedDateValue)
    }
    
    func testConstructingACalendarDateWithAnIntValueCreatesACalendarDateWithTheCorrectStringValue() {
        let givenIntValue: NSInteger = 16911
        
        let subject = CalendarDate(daysInterval: givenIntValue)
        
        let expectedDateStringValue = "2016-04-20"
        
        XCTAssertEqual(subject.getDateString(), expectedDateStringValue)
    }
}
