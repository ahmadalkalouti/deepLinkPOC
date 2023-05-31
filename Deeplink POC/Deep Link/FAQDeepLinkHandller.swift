//
//  FAQDeepLinkHandller.swift
//  Deeplink POC
//
//  Created by Ahmad Al Kalouti on 31/05/2023.
//

import Foundation
import UIKit

class FAQDeeplinkHandler: DeepLinkHandler {
    
    var deepLink: Deeplink?
    var partnerID: String = "dddd"
    
    init(deepLink: Deeplink) {
        self.deepLink = deepLink
    }
    
    func canHandle() -> Bool {
        return !partnerID.isEmpty
    }
    
    func openDeepLinkViewController() -> UIViewController? {
        let vc = UIViewController()
        vc.view.backgroundColor = .yellow
        return vc
    }
    
    func changeTabBarIndex() -> Int? {
        return nil
    }
    
    func isLoginNeeded() -> Bool {
        return true
    }
    
    func isPresent() -> Bool {
        return true
    }
}
