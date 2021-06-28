//
//  AirIndexClassifier.swift
//  CodeAssignment
//
//  Created by Mollick, Tapash on 26/06/21.
//

import Foundation

class AirQualityIndexClassifier {
    
    static func classifyAQI(aqiValue: Double) -> AirQualityIndexClassification {
        
        switch (aqiValue) {
            case (AirQualityIndexRanges.good):
                return .good
            case (AirQualityIndexRanges.satisfactory):
                return .satisfactory
            case (AirQualityIndexRanges.moderate):
                return .moderate
            case (AirQualityIndexRanges.poor):
                return .poor
            case (AirQualityIndexRanges.very_poor):
                return .very_poor
            case (AirQualityIndexRanges.severe):
                return .severe
            default:
                return .none
        }
    }
}
