//
//  MessiInterface.swift
//  Messi
//
//  Created by RongqingWang on 2018/9/3.
//  Copyright © 2020 RyukieSama. All rights reserved.
//

import Foundation
import WCDBSwift

public typealias PropertyConvertible = WCDBSwift.PropertyConvertible
public typealias Condition = WCDBSwift.Condition
public typealias OrderBy = WCDBSwift.OrderBy
public typealias Limit = WCDBSwift.Limit
public typealias Offset = WCDBSwift.Offset

public extension Messible {
    func run(transaction: Core.TransactionClosure) throws {
        try database.run(transaction: transaction)
    }
}

public extension Messible {

    /// Insert
    ///
    /// - Parameters:
    ///   - objects: objects for Insert
    ///   - propertyConvertibleList: propertyConvertibleList
    /// - Throws: MessiError
    func insert<Object: MessiTable>(objects: Object...,
        on propertyConvertibleList: [PropertyConvertible]? = nil) throws {
        try actionTable().insert(objects: objects)
    }

    func insert<Object: MessiTable>(objects: [Object],
                                           on propertyConvertibleList: [PropertyConvertible]? = nil) throws {
        try actionTable().insert(objects: objects)
    }

    func insertOrReplace<Object: MessiTable>(objects: Object...,
        on propertyConvertibleList: [PropertyConvertible]? = nil) throws {
        try actionTable().insertOrReplace(objects: objects)
    }

    func insertOrReplace<Object: MessiTable>(objects: [Object],
                                                    on propertyConvertibleList: [PropertyConvertible]? = nil) throws {
        try actionTable().insertOrReplace(objects: objects)
    }
}

public extension Messible {
    func update<Object: MessiTable>(on propertyConvertibleList: PropertyConvertible...,
        with object: Object,
        where condition: Condition? = nil,
        orderBy orderList: [OrderBy]? = nil,
        limit: Limit? = nil,
        offset: Offset? = nil) throws {
        try actionTable().update(on: propertyConvertibleList,
                                 with: object,
                                 where: condition,
                                 orderBy: orderList,
                                 limit: limit, offset: offset)
    }

    func update<Object: MessiTable>(on propertyConvertibleList: [PropertyConvertible],
                                           with object: Object,
                                           where condition: Condition? = nil,
                                           orderBy orderList: [OrderBy]? = nil,
                                           limit: Limit? = nil,
                                           offset: Offset? = nil) throws {
        try actionTable().update(on: propertyConvertibleList,
                                 with: object,
                                 where: condition,
                                 orderBy: orderList,
                                 limit: limit, offset: offset)
    }

    func update<T: MessiTable>(on propertyConvertibleList: PropertyConvertible...,
        atTable table: T,
        with row: [ColumnEncodable],
        where condition: Condition? = nil,
        orderBy orderList: [OrderBy]? = nil,
        limit: Limit? = nil,
        offset: Offset? = nil) throws {
        let table: Table<T> = try actionTable()
        try table.update(on: propertyConvertibleList,
                         with: row,
                         where: condition,
                         orderBy: orderList,
                         limit: limit,
                         offset: offset)
    }

    func update<T: MessiTable>(on propertyConvertibleList: [PropertyConvertible],
                                      atTable table: T.Type,
                                      with row: [ColumnEncodable],
                                      where condition: Condition? = nil,
                                      orderBy orderList: [OrderBy]? = nil,
                                      limit: Limit? = nil,
                                      offset: Offset? = nil) throws {
        let table: Table<T> = try actionTable()
        try table.update(on: propertyConvertibleList,
                         with: row,
                         where: condition,
                         orderBy: orderList,
                         limit: limit,
                         offset: offset)
    }
}

public extension Messible {
    func delete(fromTable table: String,
                       where condition: Condition? = nil,
                       orderBy orderList: [OrderBy]? = nil,
                       limit: Limit? = nil,
                       offset: Offset? = nil) throws {
        try database.delete(fromTable: table,
                            where: condition,
                            orderBy: orderList,
                            limit: limit,
                            offset: offset)
    }
}

public extension Messible {
    func getRows<T: MessiTable>(on columnResultConvertibleList: [ColumnResultConvertible],
                                       fromTable table: T.Type,
                                       where condition: Condition? = nil,
                                       orderBy orderList: [OrderBy]? = nil,
                                       limit: Limit? = nil,
                                       offset: Offset? = nil) throws -> FundamentalRowXColumn {
        let table: Table<T> = try actionTable()
        return try table.getRows(on: columnResultConvertibleList,
                                 where: condition,
                                 orderBy: orderList,
                                 limit: limit,
                                 offset: offset)
    }

    func getRows<T: MessiTable>(on columnResultConvertibleList: ColumnResultConvertible...,
        fromTable table: T.Type,
        where condition: Condition? = nil,
        orderBy orderList: [OrderBy]? = nil,
        limit: Limit? = nil,
        offset: Offset? = nil) throws -> FundamentalRowXColumn {
        let table: Table<T> = try actionTable()
        return try table.getRows(on: columnResultConvertibleList,
                                 where: condition,
                                 orderBy: orderList,
                                 limit: limit,
                                 offset: offset)
    }

    func getRow<T: MessiTable>(on columnResultConvertibleList: ColumnResultConvertible...,
        fromTable table: T.Type,
        where condition: Condition? = nil,
        orderBy orderList: [OrderBy]? = nil,
        offset: Offset? = nil) throws -> FundamentalRow {
        let table: Table<T> = try actionTable()
        return try table.getRow(on: columnResultConvertibleList,
                                where: condition,
                                orderBy: orderList,
                                offset: offset)
    }

    func getRow<T: MessiTable>(on columnResultConvertibleList: [ColumnResultConvertible],
                                      fromTable table: T.Type,
                                      where condition: Condition? = nil,
                                      orderBy orderList: [OrderBy]? = nil,
                                      offset: Offset? = nil) throws -> FundamentalRow {
        let table: Table<T> = try actionTable()
        return try table.getRow(on: columnResultConvertibleList,
                                where: condition,
                                orderBy: orderList,
                                offset: offset)
    }

    func getColumn<T: MessiTable>(on result: ColumnResultConvertible,
                                         fromTable table: T.Type,
                                         where condition: Condition? = nil,
                                         orderBy orderList: [OrderBy]? = nil,
                                         limit: Limit? = nil,
                                         offset: Offset? = nil) throws -> FundamentalColumn {
        let table: Table<T> = try actionTable()
        return try table.getColumn(on: result,
                                   where: condition,
                                   orderBy: orderList,
                                   limit: limit,
                                   offset: offset)
    }

    func getDistinctColumn<T: MessiTable>(on result: ColumnResultConvertible,
                                                 fromTable table: T.Type,
                                                 where condition: Condition? = nil,
                                                 orderBy orderList: [OrderBy]? = nil,
                                                 limit: Limit? = nil,
                                                 offset: Offset? = nil) throws -> FundamentalColumn {
        let table: Table<T> = try actionTable()
        return try table.getColumn(on: result,
                                   where: condition,
                                   orderBy: orderList,
                                   limit: limit,
                                   offset: offset)
    }

    func getValue<T: MessiTable>(on result: ColumnResultConvertible,
                                        fromTable table: T.Type,
                                        where condition: Condition? = nil,
                                        orderBy orderList: [OrderBy]? = nil,
                                        limit: Limit? = nil,
                                        offset: Offset? = nil) throws -> FundamentalValue {
        let table: Table<T> = try actionTable()
        return try table.getValue(on: result,
                                  where: condition,
                                  orderBy: orderList,
                                  limit: limit,
                                  offset: offset)
    }

    func getDistinctValue<T: MessiTable>(on result: ColumnResultConvertible,
                                                fromTable table: T.Type,
                                                where condition: Condition? = nil,
                                                orderBy orderList: [OrderBy]? = nil,
                                                limit: Limit? = nil,
                                                offset: Offset? = nil) throws -> FundamentalValue {
        let table: Table<T> = try actionTable()
        return try table.getValue(on: result,
                                  where: condition,
                                  orderBy: orderList,
                                  limit: limit,
                                  offset: offset)
    }

    func getTables<A: MessiTable, B: MessiTable>(on propertyConvertibleList: [PropertyConvertible],
                                                        where condition: Condition? = nil) throws -> [(A, B)] {
        let tableNames = [A.name, B.name]
        var multiSelect = try database.prepareMultiSelect(on: propertyConvertibleList, fromTables: tableNames)

        if let `condition` = condition {
            multiSelect = multiSelect.where(condition)
        }

        var tables = [(A, B)]()

        while let mutiObject = try multiSelect.nextMultiObject() {
            if let a = mutiObject[A.name] as? A, let b = mutiObject[B.name] as? B {
                tables.append((a, b))
            }
        }

        return tables
    }
}

public extension Messible {
    //TODO: Add generic property convertible to fit the type
    func getObjects<Object: MessiTable>(on propertyConvertibleList: [PropertyConvertible],
                                               where condition: Condition? = nil,
                                               orderBy orderList: [OrderBy]? = nil,
                                               limit: Limit? = nil,
                                               offset: Offset? = nil) throws -> [Object] {
        return try actionTable().getObjects(on: propertyConvertibleList,
                                            where: condition,
                                            orderBy: orderList,
                                            limit: limit,
                                            offset: offset)
    }

    func getObjects<Object: MessiTable>(on propertyConvertibleList: PropertyConvertible...,
        where condition: Condition? = nil,
        orderBy orderList: [OrderBy]? = nil,
        limit: Limit? = nil,
        offset: Offset? = nil) throws -> [Object] {
        return try actionTable().getObjects(on: propertyConvertibleList,
                                            where: condition,
                                            orderBy: orderList,
                                            limit: limit,
                                            offset: offset)
    }

    func getObject<Object: MessiTable>(on propertyConvertibleList: [PropertyConvertible],
                                              where condition: Condition? = nil,
                                              orderBy orderList: [OrderBy]? = nil,
                                              offset: Offset? = nil) throws -> Object? {
        return try actionTable().getObject(on: propertyConvertibleList,
                                           where: condition,
                                           orderBy: orderList,
                                           offset: offset)
    }

    func getObject<Object: MessiTable>(on propertyConvertibleList: PropertyConvertible...,
        where condition: Condition? = nil,
        orderBy orderList: [OrderBy]? = nil,
        offset: Offset? = nil) throws -> Object? {
        return try actionTable().getObject(on: propertyConvertibleList,
                                           where: condition,
                                           orderBy: orderList,
                                           offset: offset)
    }

    func getObject<Object: MessiTable>(where condition: Condition? = nil,
                                              orderBy orderList: [OrderBy]? = nil,
                                              offset: Offset? = nil) throws -> Object? {
        return try actionTable().getObject(on: Object.Properties.all,
                                           where: condition,
                                           orderBy: orderList,
                                           offset: offset)
    }
}

