//
//  DetailViewController.swift
//  OneLineDiary
//
//  Created by 선상혁 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var contentsLabel: UILabel!
    
    //Pass Data 1. 데이터를 받을 공간(프로퍼티) 생성
    var contents: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackgroundColor()
        
        //Pass Data 3. 전달 받은 값을 뷰에 표현
        contentsLabel.text = contents
        contentsLabel.textColor = .white
        contentsLabel.numberOfLines = 0
    }

    @IBAction func deleteButtonPressed(_ sender: UIBarButtonItem) {
        
        //push - pop (nav)
        navigationController?.popViewController(animated: true)
    }
    
}
