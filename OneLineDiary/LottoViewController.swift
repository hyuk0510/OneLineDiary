//
//  LottoViewController.swift
//  OneLineDiary
//
//  Created by 선상혁 on 2023/08/03.
//

import UIKit
import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var numberTextField: UITextField!
    
    @IBOutlet var bonusNumberLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var lottoNumberLabel: UILabel!
    
    let pickerView = UIPickerView()
    
    var list: [Int] = Array(1...1100).reversed() //Array(repeating: 10, count: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberTextField.inputView = pickerView
        numberTextField.tintColor = .clear
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        callRequest(1079)
    }
    
    func callRequest(_ num: Int) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(num)"
        
        //validate() -> 200...299
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let date = json["drwNoDate"].stringValue
                let bonusNumber = json["bnusNo"].intValue
                var lottoNum = "\(json["bnusNo"])"
                
                for num in 1...6 {
                    lottoNum += " "
                    lottoNum += String(json["drwtNo\(num)"].intValue)
                }
                
                self.dateLabel.text = date
                self.bonusNumberLabel.text = "\(bonusNumber)번"
                self.lottoNumberLabel.text = lottoNum
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberTextField.text = "\(list[row])"
        callRequest(list[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return "\(list[row])"
    }
}
