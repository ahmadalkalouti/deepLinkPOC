//
//  DeepLinkManager.swift
//  Deeplink POC
//
//  Created by Ahmad Al Kalouti on 30/05/2023.
//

import Foundation
import Combine
import UIKit

class DeepLinkManager {

    static let shared = DeepLinkManager()
    private var ddd: DeepLinkHandler? {
        didSet {
            notifyDeepLinkChanges.send(true)
        }
    }
    var notifyDeepLinkChanges = PassthroughSubject<Bool, Never>()
    var mapper = DeepLinkMapper()
    
    func addDeeplink(url: String) {
        // convet from url to Deeplink object
        let deepLink = mapper.mapFromUriToDeepLink(data: URL(string: url))
        let path = DeeplinkOptions(rawValue: deepLink.path)
        switch path {
        case .faq:
            ddd = FAQDeeplinkHandler(deepLink: Deeplink())
        default:
            break
        }
        
        ddd = FAQDeeplinkHandler(deepLink: Deeplink())
    }
    
    func updateFab(partnerID: String) {
        if let ddd = ddd as? FAQDeeplinkHandler {
            ddd.partnerID = partnerID
            notifyDeepLinkChanges.send(true)
        }
    }
    
    func checkIfThereIsDeeplink() -> (controller: UIViewController?, isPresent: Bool?, changeIndex: Int?) {
        if let ddd = ddd {
            if ddd.canHandle() {
                return (ddd.openDeepLinkViewController(), ddd.isPresent(), ddd.changeTabBarIndex())
            }
        }
        
        return (nil,nil,nil)
    }
    
}
