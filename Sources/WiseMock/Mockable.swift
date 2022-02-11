import Foundation

public protocol Mockable {
    associatedtype MockedMethod: RawRepresentable where MockedMethod.RawValue == String
    
    var mocker: Mocker { get set }

    func record(invocation: MockedMethod, with parameters: Any?...)
    func invocationCount(for name: MockedMethod) -> Int
    func parameters(for name: MockedMethod, at index: Int) -> [Any]
    func parameter<T>(for name: MockedMethod, at index: Int, andInvocation invocation: Int) -> T?
    func setReturnValue(for name: MockedMethod, with value: Any?, index: Int)
    func returnValue<T>(for name: MockedMethod) -> T?
    func reset()
}

public extension Mockable {
    
    func record(invocation name: MockedMethod, with parameters: Any?...) {
        mocker.recordInvocation(name.rawValue, paramList: parameters as [Any?])
    }

    func invocationCount(for name: MockedMethod) -> Int {
        return mocker.getInvocationCountFor(name.rawValue)
    }

    func parameters(for name: MockedMethod, at index: Int = 0) -> [Any] {
        return mocker.getParametersFor(name.rawValue, n: index) ?? []
    }

    func parameter<T>(for name: MockedMethod, at index: Int = 0, andInvocation invocation: Int = 0) -> T? {
        return parameters(for: name, at: invocation).value(at: index) as? T
    }

    func setReturnValue(for name: MockedMethod, with value: Any?, index: Int = -1) {
        mocker.setReturnValueFor(name.rawValue, returnValue: value, n: index)
    }

    func returnValue<T>(for name: MockedMethod) -> T? {
        return mocker.getReturnValueFor(name.rawValue) as? T
    }

    func reset() {
        mocker.reset()
    }
}

private extension Array {
    func value(at index: Int) -> Element? {
        guard index >= 0 && index < endIndex else {
            return nil
        }
        return self[index]
    }
}
