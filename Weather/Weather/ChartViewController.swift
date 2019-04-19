//
//  ViewController3.swift
//  test
//
//  Created by  SENAT on 18/04/2019.
//  Copyright © 2019 <ASi. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController {
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    private let timePeriod = ["Time"]
    var maxValues = [Int]()
    var minValues = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setChart(dataPoints: timePeriod, valuesMax: maxValues, valuesMin: minValues)
        
        lineChartView.animate(xAxisDuration: 0.5, yAxisDuration: 0.5, easingOption: .easeInOutSine)
    }

    private func setChart(dataPoints: [String], valuesMax: [Int], valuesMin: [Int]) {
        
        let chartData = LineChartData()
        var lineDataEntry1: [ChartDataEntry] = []
        var lineDataEntry2: [ChartDataEntry] = []
        
        // No data setup
        lineChartView.noDataTextColor = UIColor.white
        lineChartView.noDataText = "No data for the chart"
        lineChartView.backgroundColor = UIColor.white
        
        // Data point setup
        for i in 0..<valuesMax.count {
            let valuesMax = ChartDataEntry(x: Double(i), y: Double(valuesMax[i]))
            lineDataEntry1.append(valuesMax)
        }
        
        let chartDataSet1 = LineChartDataSet(entries: lineDataEntry1, label: "Temperature")
        chartData.addDataSet(chartDataSet1)
        
        
        for i in 0..<valuesMin.count {
            let valuesMin = ChartDataEntry(x: Double(i), y: Double(valuesMin[i]))
            lineDataEntry2.append(valuesMin)
        }
        
        let chartDataSet2 = LineChartDataSet(entries: lineDataEntry2, label: "Apparent temperature")
        chartData.addDataSet(chartDataSet2)
        
        // Color config
        configColorLine(chartDataSet: chartDataSet1, colors: [.red], color: .red)
        configColorLine(chartDataSet: chartDataSet2, colors: [.green], color: .green)
        
        
        // Gradient fill
        gradientFill(chartDataSet: chartDataSet1, gradient: UIColor.red.cgColor)
        gradientFill(chartDataSet: chartDataSet2, gradient: UIColor.green.cgColor)
        
        // ChartView cinfig
        lineChartView.data = chartData
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawGridLinesEnabled = true
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        lineChartView.legend.enabled = true
        lineChartView.chartDescription?.enabled = false
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = true
        lineChartView.leftAxis.drawLabelsEnabled = true
        lineChartView.xAxis.avoidFirstLastClippingEnabled = true
    }
    
    private func gradientFill(chartDataSet: LineChartDataSet, gradient: CGColor) {
        
        let gradientColor = [gradient, UIColor.red.cgColor] as CFArray
        let colorLocation: [CGFloat] = [1.0, 1.0]
        guard let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                             colors: gradientColor,
                                             locations: colorLocation)
            else { print("gradient error"); return }
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 0.0)
        chartDataSet.drawFilledEnabled = true
    }
    
    private func configColorLine(chartDataSet: LineChartDataSet, colors: [UIColor], color: UIColor) {
        
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

