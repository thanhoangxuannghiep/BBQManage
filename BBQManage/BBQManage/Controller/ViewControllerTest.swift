//
//  ViewControllerTest.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/14/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit
import Alamofire

class ViewControllerTest: UIViewController {

    @IBOutlet weak var textTest: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // Alamofire.request(<#T##url: URLConvertible##URLConvertible#>)
        // Do any additional setup after loading the view.
        textTest.text = "Thử nghiệm"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
