//
//  DatabaseProvider.swift
//  Messi
//
//  Created by RongqingWang on 2018/8/31.
//  Copyright © 2020 RyukieSama. All rights reserved.
//

import Foundation
import WCDBSwift

public typealias Database = WCDBSwift.Database
public typealias ValidationDatabaseClosure = (Database) -> Bool

public protocol DataBaseProviderType {
    associatedtype Target: DatabaseTargetType

    func database(of target: Target) -> Database
}

public extension DataBaseProviderType {

    /// 获取或者创建数据库
    ///
    /// - Parameter target:
    /// - Returns: 数据库对象
    func fetchOrCreateDatabase(of target: Target) -> Database {
        let database = Database(withFileURL: target.fileURL)
        database.tag = target.tag
        return database
    }

    /// 获取有效的数据库
    ///
    /// - Parameter target: 数据库的Target
    /// - Returns: 数据库
    /// - Throws: MessiError
    func fetchValidDatabase(of target: Target, for validation: ValidationDatabaseClosure? = nil) throws -> Database {
        let database = fetchOrCreateDatabase(of: target)

        if let `validation` = validation {
            guard validation(database) else { throw(MessiError.database(.invalid)) }
        }

        return database
    }
}

public struct DataBaseProvider<Target: DatabaseTargetType>: DataBaseProviderType {
    public init() {}

    public func database(of target: Target) -> Database {
        return fetchOrCreateDatabase(of: target)
    }
}
