
import Foundation
import ObjectMapper

struct City: Mappable {
    
    var aqi: Float?
    var city: String?
    let date = Date()
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
    aqi <- map["aqi"]
    city <- map["city"]
    }
}

extension City: Equatable {
  static func ==(lhs: City, rhs: City) -> Bool {
    return lhs.city == rhs.city && lhs.aqi == rhs.aqi
  }
}

