//
//  ApplicationServicesManager+URLOpening.swift
//  BCSTools
//
//  Created by Mikhail Pchelnikov on 31/07/2018.
//  Copyright © 2018 BCS. All rights reserved.
//

import UIKit

 extension PluggableApplicationDelegate {

    @available(iOS 9.0, *)
    open func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        var result = false
        for service in _services {
            if service.application?(app, open: url, options: options) ?? false {
                result = true
            }
        }
        return result
    }
}
