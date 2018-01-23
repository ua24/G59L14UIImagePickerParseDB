//
//  AddPhotoVC.swift
//  G59L14
//
//  Created by Ivan Vasilevich on 1/23/18.
//  Copyright © 2018 RockSoft. All rights reserved.
//

import UIKit

class AddPhotoVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	@IBOutlet weak var previewImageBox: UIImageView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	@IBAction func addPhotoPressed(_ sender: UIBarButtonItem) {
		let picker = UIImagePickerController()
		picker.delegate = self
//		picker.sourceType = .camera
		present(picker, animated: true, completion: nil)
		
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		print(info)
		dismiss(animated: true, completion: nil)
		previewImageBox.image = info[UIImagePickerControllerOriginalImage] as? UIImage
	}
	
}
