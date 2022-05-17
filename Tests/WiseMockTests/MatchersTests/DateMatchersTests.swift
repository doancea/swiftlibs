//
//  DateMatchersTests.swift
//  
//
//  Created by Daniel Oancea on 5/17/22.
//

import Foundation
import Quick
import Nimble

@testable import WiseMock

class DateMatchersTests: QuickSpec {
    override func spec() {
        describe("DateMatchers") {
            
            describe("checking if two dates are the same day") {
                   
                it("matches the same date") {
                    expect(Date()).to(beTheSameDayAs(Date()))
                    expect(Date().addingTimeInterval(1000)).to(beTheSameDayAs(Date().addingTimeInterval(-2000)))
                    expect(Date().addingTimeInterval(-1000)).to(beTheSameDayAs(Date().addingTimeInterval(2000)))
                    expect(Date.from(year: 2022, month: 5, day: 23) ).to(beTheSameDayAs(Date.from(year: 2022, month: 5, day: 23)))
                }
                
                it("does not match different dates") {
                    let date1 = Date.from(year: 2022, month: 5, day: 23)
                    let date2 = Date.from(year: 2022, month: 5, day: 24)
                    let date3 = Date.from(year: 2022, month: 4, day: 23)
                    let date4 = Date.from(year: 2021, month: 5, day: 23)
                    
                    expect(date1).notTo(beTheSameDayAs(date2))
                    expect(date1).notTo(beTheSameDayAs(date3))
                    expect(date1).notTo(beTheSameDayAs(date4))
                    expect(date3).notTo(beTheSameDayAs(date2))
                    expect(date2).notTo(beTheSameDayAs(date4))
                }
            }
        }
    }
}
        
fileprivate extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        var comps = DateComponents() // <1>
        comps.day = day
        comps.month = month
        comps.year = year

        return  Calendar.current.date(from: comps)! // <2>
    }
}
