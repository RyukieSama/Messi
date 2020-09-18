//
//  DatabaseTargetType.swift
//  Messi
//
//  Created by RongqingWang on 2018/8/31.
//  Copyright © 2020 RyukieSama. All rights reserved.
//

import Foundation

/// The protocol used to define the specifications necessary for a `MessiProvider`.
public protocol DatabaseTargetType {

    /// The target's base `URL`.
    var baseURL: URL { get }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }

    /// Init a database from existing tag.
    var tag: Int { get }

    /// database name
    var name: String { get }
}

public extension DatabaseTargetType {
    /// Init a database from file url.
    var fileURL: URL {
        var url = baseURL
        url.appendPathComponent(path)
        url.appendPathComponent(name)
        return url
    }

    var document: URL {
        return URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
    }

    var baseURL: URL {
        return document
    }
}
