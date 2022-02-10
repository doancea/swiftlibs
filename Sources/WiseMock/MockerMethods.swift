//
//  MockerMethods.swift
//  WiseMock
//
//  Created by Daniel Oancea on 2/10/22.
//  Copyright © 2022 Wiser Solutions. All rights reserved.
//

import Foundation
import Nimble


public func whenever<T: Mockable, Value>(_ mock: T, _ name: T.MockedMethod, thenReturn value: Value?, atInvocation index: Int = -1) {
    mock.setReturnValue(for: name, with: value, index: index)
}
