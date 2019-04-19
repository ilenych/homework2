//
//  ViewController3.swift
//  test
//
//  Created by  SENAT on 18/04/2019.
//  Copyright © 2019 <ASi. All rights reserved.
//

import UIKit
import Charts

class chartViewController: UIViewController {
    
    @IBOutlet weak var chartView: LineChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setChart(dataPoints: timePeriod, valuesMax: maxValues, valuesMin: minValues)
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInOutSine)
    }
    
    
    var array = [1, 4, 7, 9, 5, 7]
    var y = [0, 10, 20, 30, 40, 50]
    
    let timePeriod = ["Time", "1", "2", "3", "2", "3"]
    let maxValues = [2.0, 6.0, 5.0, 2.0, 0.0, 4.0]
    let minValues = [-4.0, 0.0, -2.0, -6.0, -10.0, -3.0]
    
    
    
    func setChart(dataPoints: [String], valuesMax: [Double], valuesMin: [Double]) {
        
        let chartData = LineChartData()
        var lineDataEntry1: [ChartDataEntry] = []
        var lineDataEntry2: [ChartDataEntry] = []
        
        // No data setup
        chartView.noDataTextColor = UIColor.white
        chartView.noDataText = "No data for the chart"
        chartView.backgroundColor = UIColor.white
        
        // Data point setup
        for i in 0..<valuesMax.count {
            let valuesMax = ChartDataEntry(x: Double(i), y: valuesMax[i])
            lineDataEntry1.append(valuesMax)
        }
        let chartDataSet1 = LineChartDataSet(entries: lineDataEntry1, label: "max")
        chartData.addDataSet(chartDataSet1)
        
        
        for i in 0..<valuesMin.count {
            let valuesMin = ChartDataEntry(x: Double(i), y: valuesMin[i])
            lineDataEntry2.append(valuesMin)
        }
        let chartDataSet2 = LineChartDataSet(entries: lineDataEntry2, label: "min")
        chartData.addDataSet(chartDataSet2)
        
        // Color config
        configColorLine(chartDataSet: chartDataSet1, colors: [.red], color: .red)
        configColorLine(chartDataSet: chartDataSet2, colors: [.green], color: .green)
        
        
        // Gradient fill
        gradientFill(chartDataSet: chartDataSet1, gradient: UIColor.red.cgColor)
        gradientFill(chartDataSet: chartDataSet2, gradient: UIColor.green.cgColor)
        
        chartView.data = chartData
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = true
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        chartView.legend.enabled = true
        chartView.chartDescription?.enabled = false
        chartView.rightAxis.enabled = false
        chartView.leftAxis.drawGridLinesEnabled = true
        chartView.leftAxis.drawLabelsEnabled = true
        chartView.xAxis.avoidFirstLastClippingEnabled = true
    }
    
    func gradientFill(chartDataSet: LineChartDataSet, gradient: CGColor) {
        let gradientColor = [gradient, UIColor.red.cgColor] as CFArray
        let colorLocation: [CGFloat] = [1.0, 1.0]
        guard let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColor, locations: colorLocation) else { print("gradient error"); return }
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 0.0)
        chartDataSet.drawFilledEnabled = true
    }
    
    func configColorLine(chartDataSet: LineChartDataSet, colors: [UIColor], color: UIColor) {
        chartDataSet.colors = colors
        chartDataSet.setCircleColors(color)
        chartDataSet.circleHoleColor = color
        chartDataSet.circleRadius = 2.0
        chartDataSet.mode = .cubicBezier
        chartDataSet.cubicIntensity = 0.2
        chartDataSet.drawCirclesEnabled = true
        chartDataSet.drawValuesEnabled = false
    }
}

