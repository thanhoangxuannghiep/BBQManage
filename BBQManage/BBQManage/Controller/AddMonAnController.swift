//
//  AddMonAnController.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/14/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class AddMonAnController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var txtTenMon: UITextField!
    @IBOutlet weak var txtMoTa: UITextView!
    @IBOutlet weak var txtGiaTien: UITextField!
    
    
    @IBOutlet weak var slideshowScrollView: UIScrollView!
    //DS hình ảnh dc chọn
    var selectedImagesQueue = [UIImage]()
    //Tạo đối tượng image picker
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Click_ChonAnh(_ sender: UIButton) {
        present(imagePicker, animated: true)
    }

    //imagePicker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true)
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            selectedImagesQueue += [pickedImage] // Đưa vào hàng đợi để lưu
            addImageTo(scrollView: slideshowScrollView, image: pickedImage)
        }
    }

}
