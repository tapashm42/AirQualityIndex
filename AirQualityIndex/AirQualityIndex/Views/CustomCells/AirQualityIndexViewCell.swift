//
//  AirQualityIndexViewCell.swift
//  CodeAssignment
//
//  Created by Mollick, Tapash on 20/06/21.
//

import UIKit

protocol AirQualityIndexable {
    var type: (condition: String, color: UIColor) { get }
}

enum AirQualityIndexRanges {
    // In the Health App the  range is set up between 40 and 300
    static let good = 0.00...50.99
    static let satisfactory = 51.00...100.99
    static let moderate = 101.00...200.99
    static let poor = 201.00...300.99
    static let very_poor = 301.00...400.99
    static let severe = 401.00...500.99
    case outOfRange
}

enum AirQualityIndexClassification {
    case good
    case satisfactory
    case moderate
    case poor
    case very_poor
    case severe
    case none
}

extension AirQualityIndexClassification: AirQualityIndexable {
    var type: (condition: String, color: UIColor) {
        get {
            switch self {
                case .good:
                    return (condition: "Good", color: .systemGreen)
                case .satisfactory:
                    return (condition: "Satisfactory", color: UIColor.AQIColor.lightGreen)
                case .moderate:
                    return (condition: "Moderate", color: .systemYellow)
                case .poor:
                    return (condition: "Poor", color: .systemOrange)
                case .very_poor:
                    return (condition: "Very Poor", color: .systemRed)
                case .severe:
                    return (condition: "Severe", color: UIColor.AQIColor.darkRed)
                case .none:
                    return (condition: "", color: .white)
            }
        }
    }
}



class AirQualityIndexViewCell: UITableViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var indexLevel: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var severityLevel: UILabel!

    var city: City? {
        didSet {
            guard let newCity = city else {
                return
            }
            set(for: newCity)
        }
    }
    
    func set(for city: City) {
        cityLabel.text = city.city
        guard let aqi = city.aqi else {
            return
        }
        indexLevel.text = String(format: " %.2f", aqi)
        let aqi2 = (AirQualityIndexClassifier.classifyAQI(aqiValue: Double(aqi)))
        progressView.backgroundColor = aqi2.type.color
        severityLevel.text = aqi2.type.condition
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension UITableViewCell {

    public func eg_roundCorners() {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }

    static var identifier: String {
        get {
            return NSStringFromClass(classForCoder()).components(separatedBy: ".").last!
        }
    }
}


//class cellDataModel {
//    let city: String
//    let aqi: [cellDataAQIModel]
//    init(city: String, aqi: [cellDataAQIModel]) {
//        self.aqi = aqi
//        self.city = city
//    }
//}
//
//class cellDataAQIModel {
//    let aqi: Float
//    let date: Date
//    init(aqi: Float, date: Date = Date()) {
//        self.aqi = aqi
//        self.date = date
//    }
//}
