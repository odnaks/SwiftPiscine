//
//  MyError.swift
//  day04
//
//  Created by Kseniya Lukoshkina on 28.11.2020.
//  Copyright © 2020 Dremora Restless. All rights reserved.
//

import Foundation

enum MyError: String, Error {
    case requestError
    case networkError
    case jsonError
    case uiError
    case tokenError
}

extension MyError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .requestError:
            return "request error"
        case .networkError:
            return "network error"
        case .jsonError:
            return "json error"
        case .uiError:
            return "ui error"
        case .tokenError:
            return "token error"
        }
    }
}
