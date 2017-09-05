//
//  UIViewController+Analytics.swift
//  LetsGo
//
//  Created by Menem Ragab on 9/5/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit
import Firebase
extension UIViewController {

    
    func LogScreenLoad() {
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-\(self.title!)Opened" as NSObject,
            AnalyticsParameterItemName: self.title! as NSObject,
            AnalyticsParameterContentType: "cont" as NSObject
            ])
    }
}
