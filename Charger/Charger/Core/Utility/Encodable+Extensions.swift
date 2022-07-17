//
//  Encodable+Extensions.swift
//  Charger
//
//  Created by Hande Kara on 7/17/22.
//

import Foundation

extension Encodable {
    func toDictionary(_ encoder: JSONEncoder) throws -> [String: Any] {
    let data = try encoder.encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}
