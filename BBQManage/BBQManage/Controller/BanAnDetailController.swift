//
//  BanAnDetailController.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/15/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class BanAnDetailController: UIViewController {

    @IBOutlet weak var TableBanAnDetail: UITableView!
    @IBOutlet weak var txtTongTien: UILabel!
    
    //Biến lưu id bàn ăn
    var idBA : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Click_TinhTien(_ sender: UIButton) {
        
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
