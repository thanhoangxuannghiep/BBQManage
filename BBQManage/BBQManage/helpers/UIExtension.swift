//
//  UIExtension.swift
//  BBQManage
//
//  Created by Than Hoang Xuan Nghiep on 6/15/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
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
    
    func upImage(post: String?, urlPost: String? ) {
        
        
        let url: URL = URL(string: urlPost!)!
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = post?.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if error != nil {
                print(error)
            }else {
                let contentRun = String(data: data!, encoding: String.Encoding.utf8)
                print(contentRun)
            }
        }
        task.resume()
    }
}
