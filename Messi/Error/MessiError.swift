//
//  MessiError.swift
//  Messi
//
//  Created by RongqingWang on 2018/8/31.
//  Copyright © 2020 RyukieSama. All rights reserved.
//

import Foundation

public enum MessiError: Error {
    case database(ErrorType)
    case table(TableErrorType)
    case custom(String)
    case empty

    public enum ErrorType {
        case notExist
        case invalid
    }

    public enum TableErrorType {
        case notExist
        case createFailure
    }
}

extension MessiError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .database(let type):
            switch type {
            case .invalid:
                return "database invalid"
            case .notExist:
                return "database notExist"
            }
        case .table(let type):
            switch type {
            case .createFailure:
                return "table create failure"
            case .notExist:
                return "table notExist"
            }
        case .empty:
            return "empty"
        case .custom(let errorDes):
            return errorDes
        }
    }
}
