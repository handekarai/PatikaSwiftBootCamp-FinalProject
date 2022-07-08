//
//  HTTPRequest.swift
//  Charger
//
//  Created by Hande Kara on 7/9/22.
//

import Foundation

enum HTTPRequest: String {
    case delete = "DELETE"
    case get = "GET"
    case post = "POST"
}

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
}
