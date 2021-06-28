//
//  Array+Extensions.swift
//  AirQualityIndex
//
//  Created by Mollick, Tapash on 28/06/21.
//

import Foundation

extension Array {
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element] {
        var dict = [Key:Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}
