//
//  Messible.swift
//  Messi
//
//  Created by RongqingWang on 2018/9/4.
//  Copyright © 2020 RyukieSama. All rights reserved.
//

import Foundation
import WCDBSwift

public typealias TableCodable = WCDBSwift.TableCodable
public typealias Table = WCDBSwift.Table

public protocol MessiServiceable where TableType.RawValue == String {
    associatedtype TableType: RawRepresentable

    static var tableType: TableType { get }
}

public extension MessiServiceable {
    static var name: String {
        return tableType.rawValue
    }
}

public typealias MessiTable = MessiServiceable & TableCodable

public protocol Messible where Tables.RawValue == String {
    associatedtype Tables: RawRepresentable

    /// 访问的databsae
    var database: Database { get set }
}

public extension Messible {
    typealias Object = MessiTable

    func getAll<T: Object>() throws -> [T] {
        do {
            return try database.getObjects(fromTable: T.name)
        } catch {
            let select = StatementSelect()
            select.select(T.Properties.all)

            throw MessiError.custom("Get all failure for table: \(T.name) SQL: \(select.description)")
        }
    }

    internal func actionTable<T: MessiTable>() throws -> Table<T> {
        guard
            let table = try database.getTable(named: T.name, of: T.self)
            else {
                throw MessiError.table(.notExist)
        }

        return table
    }

    func create<T: MessiTable>(table: T.Type) throws {
        do {
            try database.create(table: table.name, of: table)
        } catch {
            throw MessiError.table(.createFailure)
        }
    }
}
