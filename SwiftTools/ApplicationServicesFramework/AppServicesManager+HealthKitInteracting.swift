//
//  ApplicationServicesManager+HealthKitInteracting.swift
//  BCSTools
//
//  Created by Mikhail Pchelnikov on 31/07/2018.
//  Copyright © 2018 BCS. All rights reserved.
//

import UIKit

 extension PluggableApplicationDelegate {

    @available(iOS 9.0, *)
    open func applicationShouldRequestHealthAuthorization(_ application: UIApplication) {
        for service in _services {
            service.applicationShouldRequestHealthAuthorization?(application)
        }
    }
}
