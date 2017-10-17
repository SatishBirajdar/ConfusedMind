//
//  SelectItemViewController.swift
//  ConfusedMind
//
//  Created by Satish Birajdar on 2017-10-04.
//  Copyright © 2017 SBSoftwares. All rights reserved.
//

import Foundation
import UIKit
import Charts

class SelectItemViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var itemsView: PieChartView!
    var months: [String]!
    
    @IBOutlet weak var spinButton: UIButton!
    init() {
        super.init(nibName: "SelectItemView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Chart"
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "editPencil"), for: .normal)
//        button.setTitle("Button kjnsakndfkna", for: .normal)
//        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        button.bounds = CGRect(x: 0, y: 0, width: 25, height: 25)
//        button.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem?.imageInsets = .init(top: 0, left: 0, bottom: 0, right: 0)

    
        itemsView.noDataText = "No data jkbksdbkfb"
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        
        setChart(dataPoints: months, values: unitsSold)
        

        /**
         Notify PieChart about the change
         */
        itemsView.notifyDataSetChanged()
        itemsView.delegate = self

    }
    
    func addButtonClicked(sender: UIBarButtonItem){
        print("Clicked")
        self.navigationController?.pushViewController(ItemListViewController(), animated: true)
    }
    
    @IBAction func spinButtonAction(_ sender: Any) {
        self.itemsView.spin(duration: 3, fromAngle: 0, toAngle: 1000)
        
        var selectedData = self.itemsView.data?.getDataSetByIndex(0).entryForIndex(2)
        
        itemsView.highlightValue(x: 4.0, y: 0.0, dataSetIndex: 0)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data:  dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
            
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Units Sold")
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartData.setDrawValues(false)
//        hoursPieChartView.legend.labels = [label]
        self.itemsView.data = pieChartData
        
        
//        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Units Sold")
//        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
//        itemsView.data = pieChartData
        
        var colors: [UIColor] = []
        
        for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors
        
        
    }
    
}
