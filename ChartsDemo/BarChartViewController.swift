//
//  BarChartViewController.swift
//  ChartsDemo
//
//  Created by apple on 16/08/17.
//  Copyright © 2017 efftronics. All rights reserved.
//

import UIKit
import Charts

class BarChartViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtfield: UITextField!
    
    @IBOutlet weak var chartview: BarChartView!
    
    var numbers = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.txtfield.delegate = self;
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        let tapG: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        
        chartview.addGestureRecognizer(tapG)
    }
    
   
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func buttontappedd(_ sender: UIButton) {
        if let input = Double((txtfield.text!)) {
            numbers.append(input)
            txtfield.text = ""
            updateGraph()
            chartview.alpha = 1.0
        }
    }
    func updateGraph(){
        
        var barChartEntry = [BarChartDataEntry]()
        
        for i in 0..<numbers.count {
            let value = BarChartDataEntry(x: Double(i), y: numbers[i])
            barChartEntry.append(value)
        }
        
        let bar1 = BarChartDataSet(values: barChartEntry, label: "Numbers")
        bar1.colors = [NSUIColor.orange]
        let data = BarChartData()
        data.addDataSet(bar1)
        chartview.data = data
        chartview.chartDescription?.text = "My awesome Bar chart"
    }
    func  textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters =  CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        let isNumber =  allowedCharacters.isSuperset(of: characterSet)
        let currentCharacterCount = textField.text?.characters.count ?? 0
        let newLength = currentCharacterCount + string.characters.count
        
        if ((isNumber == true) && (newLength <= 20)){
            return true
        }
        else{
            return false
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
