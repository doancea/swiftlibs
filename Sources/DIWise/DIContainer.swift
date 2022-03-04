//
//  DIContainer.swift
//  mobee
//
//  Created by Daniel Oancea on 2/8/22.

/**
 Dependency Injection approach originally taken from here:
 https://www.raywenderlich.com/14223279-dependency-injection-tutorial-for-ios-getting-started
 
 Testing this out as a solution to DI for iOS, which is very helpful in writing testable code
 */

import Foundation

protocol DIContainerProtocol {
  func register<Component>(type: Component.Type, component: Any)
  func resolve<Component>(type: Component.Type) -> Component?
}

final class DIContainer: DIContainerProtocol {
  static let shared = DIContainer()
  
  private init() {}

  var components: [String: Any] = [:]

  func register<Component>(type: Component.Type, component: Any) {
    components["\(type)"] = component
  }

  func resolve<Component>(type: Component.Type) -> Component? {
    return components["\(type)"] as? Component
  }
}
