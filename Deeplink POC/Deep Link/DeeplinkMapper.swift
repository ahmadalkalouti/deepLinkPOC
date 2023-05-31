//
//  DeeplinkMapper.swift
//  Deeplink POC
//
//  Created by Ahmad Al Kalouti on 31/05/2023.
//

import Foundation

struct DeepLinkMapper {
    private static let TAG_SLASH = "/"
    private static let QUERY_SEP_CHAR: Character = "&"
    private static let QUERY_KEY_VALUE_SEP_CHAR: Character = "="
    private static let PATH_SEP_CHAR = "?"
    private static let CAMPAIGN_PREFIX = "utm"

    func mapFromUriToDeepLink(data: URL?) -> Deeplink {
        var deepLink = Deeplink()
        var pathIdentifier = data?.path.lowercased() ?? ""
        pathIdentifier = handleAdjustDeepLinkPath(pathIdentifier: pathIdentifier, data: data) ?? ""
        deepLink.path = pathIdentifier

        if let queries = data?.query?.split(separator: DeepLinkMapper.QUERY_SEP_CHAR) {
            pathIdentifier += DeepLinkMapper.PATH_SEP_CHAR
            for queryParam in queries {
                let keyValue = queryParam.split(separator: DeepLinkMapper.QUERY_KEY_VALUE_SEP_CHAR)
                if let key = keyValue.first?.trimmingCharacters(in: .whitespacesAndNewlines),
                   let value = keyValue.last?.trimmingCharacters(in: .whitespacesAndNewlines) {
                    deepLink.queries[key] = value

                    if !key.hasPrefix(DeepLinkMapper.CAMPAIGN_PREFIX) {
                        pathIdentifier += key
                        if queries.last != queryParam {
                            pathIdentifier += String(DeepLinkMapper.QUERY_SEP_CHAR)
                        }
                    }
                }
            }
        }
        return deepLink
    }

    private func handleAdjustDeepLinkPath(pathIdentifier: String?, data: URL?) -> String? {
        var pathIdentifierPath = pathIdentifier
        if isAdjustDeepLink(data: data) {
            if data?.path.isEmpty ?? false {
                pathIdentifierPath = URL(string: data!.absoluteString.replacingOccurrences(
                    of: "share://",
                    with: "share://" + DeepLinkMapper.TAG_SLASH
                ))?.path.lowercased()
            }
        }
        return pathIdentifierPath
    }

    private func isAdjustDeepLink(data: URL?) -> Bool {
        return data?.absoluteString.hasPrefix("share://") ?? false
    }
}
