//
//  Endpoint.swift
//  Charger
//
//  Created by Hande Kara on 7/9/22.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPRequest { get }
    var headers: [String: String]? { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var baseURL: String {
        return "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/"
    }
    var URL: String {
        return baseURL + path
    }
}
