import Foundation
import Nimble

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

/// Equatable
public func invoke<T: Mockable, E: Equatable>(_ name: T.MockedMethod, atInvocation invocationIndex: Int = 0, withParameter parameter: E?, at parameterIndex: Int = 0) -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in

        failureMessage.postfixMessage = "invoke \(name) with \(parameter) at index \(parameterIndex) on invocation \(invocationIndex)"

        if let mockable = try actualExpression.evaluate() {
            let actualParameter: E? = mockable.parameter(for: name, at: parameterIndex, andInvocation: invocationIndex)
            failureMessage.actualValue = "\(actualParameter)"
            return actualParameter == parameter
        }

        return false
    }
}

/// Identity
public func invoke<T: Mockable, E: AnyObject>(_ name: T.MockedMethod, atInvocation invocationIndex: Int = 0, withIdenticalParameter parameter: E?, at parameterIndex: Int = 0) -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in

        failureMessage.postfixMessage = "invoke \(name) with \(parameter) at index \(parameterIndex) on invocation \(invocationIndex)"

        if let mockable = try actualExpression.evaluate() {
            let actualParameter: E? = mockable.parameter(for: name, at: parameterIndex, andInvocation: invocationIndex)
            failureMessage.actualValue = "\(actualParameter)"
            return actualParameter === parameter
        }

        return false
    }
}

/// Closure Matcher
public func invoke<T: Mockable, U>(_ name: T.MockedMethod, atInvocation invocationIndex: Int = 0, atParameterIndex parameterIndex: Int = 0, withMatcher matcher: @escaping ((U?) -> Bool?)) -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in

        failureMessage.postfixMessage = "invoke \(name) with matching parameter at index \(parameterIndex) on invocation \(invocationIndex)"

        if let mockable = try actualExpression.evaluate() {
            let actualValue: U? = mockable.parameter(for: name, at: parameterIndex, andInvocation: invocationIndex)
            failureMessage.actualValue = "parameter as \(actualValue)"
            return matcher( actualValue ) ?? false
        }

        return false
    }
}
