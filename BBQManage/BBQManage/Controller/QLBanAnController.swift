//
//  QLBanAnController.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/14/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class QLBanAnController: UIViewController {

    @IBOutlet weak var QLBanAnTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Danh sách bàn ăn"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addTapped()
    {
        performSegue(withIdentifier: "addBanAn", sender: self)
    }

    
}
