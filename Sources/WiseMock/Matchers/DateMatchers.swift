//
//  File.swift
//  
//
//  Created by Daniel Oancea on 5/17/22.
//

import Foundation
import Nimble


public func beTheSameDayAs(_ expectedDate: Date) -> Predicate<Date> {
    return Predicate<Date>.define { actualExpression in
        var expectationMessage: ExpectationMessage!
        var status: PredicateStatus!
        
        if let actualDate = try? actualExpression.evaluate() {
            let actualMessage = String(describing: actualDate)
            
            expectationMessage = .expectedActualValueTo(actualMessage)
            
            
            status = PredicateStatus(bool: isSameDay(date1: actualDate, date2: expectedDate))
        } else {
            status = .fail
            expectationMessage = .fail("something else happened")
        }
        return PredicateResult(status: status, message: expectationMessage)
    }
}

fileprivate func isSameDay(date1: Date, date2: Date) -> Bool {
    let diff = Calendar.current.dateComponents([.year, .month, .day], from: date1, to: date2)
    
    return diff.day == 0 && diff.month == 0 && diff.year == 0
}
