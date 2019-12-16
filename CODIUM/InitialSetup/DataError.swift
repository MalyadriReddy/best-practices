//
//  DataError.swift
//  CODIUM
//
//  Created by Malyadri Reddy on 15/12/19.
//  Copyright © 2019 codium. All rights reserved.
//

import Foundation

public enum DataError: Error {
    case nonExistent
    case unauthorized
    case noInternet
    case parseFailure(Error?)
    case databaseFailure(Error?)
    case cacheFailure(Error?)
    case networkFailure(Error?)
    case unknownReason(Error?)
}

