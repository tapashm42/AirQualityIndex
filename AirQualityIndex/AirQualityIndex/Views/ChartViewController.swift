//
//  ChartViewController.swift
//  CodeAssignment
//
//  Created by Mollick, Tapash on 26/06/21.
//

import UIKit
import Charts

class ChartViewController: UIViewController {
    @IBOutlet var chartView: BarChartView!
    
    var city: String = ""
    var times: [String]!
    var aqiValues: [Double]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = city
        times = ["10:00:09", "10:10:09", "10:20:09", "10:30:09", "10:40:09", "10:50:09", "10:60:09", "10:70:09", "10:80:09"]
        aqiValues = [101.00, 52.00, 224.00, 285.00, 207.00, 409.00, 159.00, 55.00, 332.00]
        setChart(dataEntryX: times, dataEntryY: aqiValues)
    }
    
    func setChart(dataEntryX forX:[String],dataEntryY forY: [Double]) {
        chartView.noDataText = "You need to provide data for the chart."
        var dataEntries:[BarChartDataEntry] = []
        for i in 0..<forX.count{
            // print(forX[i])
            // let dataEntry = BarChartDataEntry(x: (forX[i] as NSString).doubleValue, y: Double(unitsSold[i]))
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(forY[i]) , data: times as AnyObject?)
            print(dataEntry)
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Air Quality Index")
//        chartDataSet.colors = ChartColorTemplates.material()
        chartDataSet.colors = aqiValues.map { setColor(value: $0) }
        let chartData = BarChartData(dataSet: chartDataSet)
        chartView.data = chartData
        let xAxisValue = chartView.xAxis
        xAxisValue.valueFormatter = self
    }
    
    func setColor(value: Double) -> UIColor{
        let barType = (AirQualityIndexClassifier.classifyAQI(aqiValue: Double(value)))
        return barType.type.color
    }
}

extension ChartViewController: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return times[Int(value)]
    }
}

