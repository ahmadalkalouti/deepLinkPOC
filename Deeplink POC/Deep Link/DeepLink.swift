//
//  DeepLink.swift
//  Deeplink POC
//
//  Created by Ahmad Al Kalouti on 30/05/2023.
//

import Foundation
import UIKit

struct Deeplink {
    var path: String = ""
    var queries: [String: String] = [:]
}

enum DeeplinkOptions: String {
    case faq
}
