//
//  BaoCaoController.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/13/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class BaoCaoController: UIViewController {

    @IBOutlet weak var daybeginPicker: UIDatePicker!
    @IBOutlet weak var dayendPicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Thống kê thu nhập"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Click_ThongKe(_ sender: UIButton) {
        let daybegin = daybeginPicker.date
        let dayend = dayendPicker.date
        print(daybegin)
        print(dayend)
    }

    

}
