//
//  DeepLinkHandler.swift
//  Deeplink POC
//
//  Created by Ahmad Al Kalouti on 30/05/2023.
//

import Foundation
import UIKit

protocol DeepLinkHandler {
    func canHandle() -> Bool
    func openDeepLinkViewController() -> UIViewController?
    func changeTabBarIndex() -> Int?
    func isLoginNeeded() -> Bool
    func isPresent() -> Bool
}

protocol QueriesDeepLinkHandler: DeepLinkHandler {
    // Additional methods specific to QueriesDeepLinkHandler
    // can be added here if needed
}
