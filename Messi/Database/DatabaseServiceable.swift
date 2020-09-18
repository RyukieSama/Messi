//
//  DatabaseServiceable.swift
//  Ledger
//
//  Created by 王荣庆 on 2020/5/4.
//  Copyright © 2020 RyukieSama. All rights reserved.
//

import Foundation

public protocol DatabaseServiceable {
    
}

public extension DatabaseServiceable where Self: DatabaseTargetType {
    static var provider: DataBaseProvider<Self> {
        return DataBaseProvider<Self>()
    }
}
