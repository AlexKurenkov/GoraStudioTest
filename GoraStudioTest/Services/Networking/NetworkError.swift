//
//  NetworkError.swift
//  GoraStudioTest
//
//  Created by Александр on 08.02.2021.
//

import Foundation

// MARK: - response error enum
enum NetworkError: Error {
    
    case noHTTPResponse
    case noDataReceived
    case unacceptableStatusCode
}
