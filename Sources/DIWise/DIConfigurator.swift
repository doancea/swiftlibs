//
//  DIConfigurator.swift
//  mobee
//
//  Created by Daniel Oancea on 2/8/22.
//

import Foundation
import Segment
import UIKit
import CoreLocation

@objcMembers
public open class DIConfigurator: NSObject {
    
    private static let container: DIContainerProtocol = DIContainer.shared
    
    public static func configuredComponentSingleton<Component>(_ type: Component.Type, factory: () -> Component) -> Component {
        if let it = container.resolve(type: type) {
            return it
        } else {
            let it = factory()
            
            container.register(type: type, component: it)
            
            return it
        }
    }
}
