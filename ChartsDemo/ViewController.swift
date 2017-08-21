//
//  ViewController.swift
//  ChartsDemo
//
//  Created by apple on 14/08/17.
//  Copyright © 2017 efftronics. All rights reserved.
//

import UIKit
import Charts
class ViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var chtChart: LineChartView!
    @IBOutlet weak var txtTextBox: UITextField!
    
    var numbers = [Double]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtTextBox.delegate = self;
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        let tapG: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        
        chtChart.addGestureRecognizer(tapG)
        
    }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
 
    @IBAction func buttonTapped(_ sender: Any) {
        
        if let input = Double((txtTextBox.text!)) {
            numbers.append(input)
            txtTextBox.text = ""
            updateGraph()
            chtChart.alpha = 1.0
            
        }
    }
    func updateGraph() {
        
        var lineChartEntry = [ChartDataEntry]()
        
        for i in 0..<numbers.count {
            let value = ChartDataEntry(x: Double(i), y: numbers[i])
            lineChartEntry.append(value)
        }
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Number")
        line1.colors = [NSUIColor.blue]
        let data = LineChartData()
        data.addDataSet(line1)
        chtChart.data = data
        chtChart.chartDescription?.text = "My awesome Line Chart"
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

