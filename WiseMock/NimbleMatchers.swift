import Foundation
import Nimble

///Invocation Count
public func invoke<T: Mockable>(_ name: T.MockedMethod, times: Int = 1) -> Predicate<T> {
    
    return Predicate<T>.define { actualExpression in
        var expectationMessage: ExpectationMessage!
        var status: PredicateStatus!
        
        if let mockable = try? actualExpression.evaluate() {
            let failureExpectationMessage = "invoke \(name) \(times) times"
            let actualMessage = "\(mockable.invocationCount(for: name)) invocations"
            status = PredicateStatus(bool: mockable.invocationCount(for: name) == times)
            expectationMessage = .expectedCustomValueTo(failureExpectationMessage, actual: actualMessage)
        } else {
            status = .fail
            expectationMessage = .fail("something else happened")
        }
        return PredicateResult(status: status, message: expectationMessage)
    }

}

///Equality
public func invoke<T: Mockable, E: Equatable>(_ name: T.MockedMethod, atInvocation invocationIndex: Int = 0, withParameter parameter: E?, at parameterIndex: Int = 0) -> Predicate<T> {
    return Predicate<T>.define { actualExpression in
        var expectationMessage: ExpectationMessage!
        var status: PredicateStatus!
        
        if let mockable = try? actualExpression.evaluate() {
            let actualParameter: E? = mockable.parameter(for: name, at: parameterIndex, andInvocation: invocationIndex)
            let actualMessage = String(describing: actualParameter)
            
            expectationMessage = .expectedActualValueTo(actualMessage)
            status = PredicateStatus(bool: actualParameter == parameter)
        } else {
            status = .fail
            expectationMessage = .fail("something else happened")
        }
        return PredicateResult(status: status, message: expectationMessage)
    }

}

///Identity
public func invoke<T: Mockable, E: AnyObject>(_ name: T.MockedMethod, atInvocation invocationIndex: Int = 0, withIdenticalParameter parameter: E?, at parameterIndex: Int = 0) -> Predicate<T> {
    return Predicate<T>.define { actualExpression in
        var expectationMessage: ExpectationMessage!
        var status: PredicateStatus!
        
        if let mockable = try? actualExpression.evaluate() {
            let actualParameter: E? = mockable.parameter(for: name, at: parameterIndex, andInvocation: invocationIndex)
            let actualMessage = String(describing: actualParameter)
            
            expectationMessage = .expectedActualValueTo(actualMessage)
            status = PredicateStatus(bool: actualParameter === parameter)
        } else {
            status = .fail
            expectationMessage = .fail("something else happened")
        }
        return PredicateResult(status: status, message: expectationMessage)
    }
}

/// Closure Matcher
public func invoke<T: Mockable, U>(_ name: T.MockedMethod, atInvocation invocationIndex: Int = 0, atParameterIndex parameterIndex: Int = 0, withMatcher matcher: @escaping ((U?) -> Bool)) -> Predicate<T> {
    return Predicate<T>.define { actualExpression in
        var expectationMessage: ExpectationMessage!
        var status: PredicateStatus!
        
        if let mockable = try? actualExpression.evaluate() {
            let actualParameter: U? = mockable.parameter(for: name, at: parameterIndex, andInvocation: invocationIndex)
            
            expectationMessage = .fail("parameter as \(String(describing: actualParameter)) does not match")
            status = PredicateStatus(bool: matcher(actualParameter))
        } else {
            status = .fail
            expectationMessage = .fail("something else happened")
        }
        return PredicateResult(status: status, message: expectationMessage)
    }
}
