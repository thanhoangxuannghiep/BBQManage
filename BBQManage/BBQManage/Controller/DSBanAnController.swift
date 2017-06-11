//
//  DSBanAnController.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/11/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class DSBanAnController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var DSBanan: UITableView!
    
    //Số liệu dùng để hiển thị hay không hiển thi left menu
    @IBOutlet weak var LeadingSpaceLeftMenu: NSLayoutConstraint!
    var menushow = false // => flag để xét có hiển thị menu hay không
    
    //data test thử => có thể xoá
    let pickerData = ["Lớp 1", "Lớp 2", "Lớp 3"]
    
    //Left menu
    @IBOutlet weak var btnQLKhuVuc: UIButton!
    @IBOutlet weak var btnQLBanAn: UIButton!
    @IBOutlet weak var btnQLNhanVien: UIButton!
    @IBOutlet weak var btnQLMonAn: UIButton!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblTenUser: UILabel!
    @IBOutlet weak var btnDangXuat: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.DSBanan.delegate = self
        self.DSBanan.dataSource = self
        
        //Vô hiệu hoá các nút quản lý nếu user không phải là chủ
        btnQLBanAn.isEnabled = false
        btnQLKhuVuc.isEnabled = false
        btnQLNhanVien.isEnabled = false
        btnQLMonAn.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Cài đặt cho Tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BanAnCell") as! BanAnCell
        cell.TenBanAn.text = pickerData[indexPath.row]
        return cell
    }
    
    @IBAction func ClickMenu(_ sender: Any) {
        if(menushow) //Menu đang mở thì tắt đi
        {
            LeadingSpaceLeftMenu.constant = -194
        }
        else // đang tắt thì mở
        {
            LeadingSpaceLeftMenu.constant = 0
        }
        menushow = !menushow
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
