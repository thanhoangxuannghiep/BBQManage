//
//  UIExtension.swift
//  BBQManage
//
//  Created by John on 6/16/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

extension UIViewController {
        func addImageTo(scrollView: UIScrollView, image: UIImage) {
            let width = CGFloat(100)
            let height = CGFloat(100)
            let spacing = CGFloat(10)
            
            let size = scrollView.contentSize // Kích thước hiện tại
            var count = CGFloat(0)
            
            if (size.width > 0) { // Đang  chứa bao nhiêu hình?
                count = (size.width - spacing ) / (width + spacing)
            }
            
            // Tạo mới một imageview
            let img = UIImageView(frame: CGRect(x: spacing + (width + spacing) * count, y:10, width: width, height: height))
            img.image = image
            scrollView.addSubview(img) // Thêm ảnh mới vào scrollview
            
            // Cập nhật lại kích thước của content size để chứa hình mới
            count += 1
            scrollView.contentSize = CGSize(width: spacing + (width + spacing) * CGFloat(count), height: height)
            
        }
        
        func alert(title: String, message: String, handler: @escaping (UIAlertAction) -> Void ) {
            let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        //show options when using camera or photo lib
        func showOption(imagePicker : UIImagePickerController?){
            //        let alert = UIAlertController()
            //        alert.addAction(UIAlertAction(title: "Take new photo", style: .default, handler: { (finished) in
            //            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            //                imagePicker = UIImagePickerController()
            //                imagePicker.delegate = _
            //                imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            //                imagePicker.allowsEditing = false
            //                _ = presentedViewController(imagePicker, dismiss(animated: true, completion: nil))
            //
            //            }
            //        }))
        }

}
