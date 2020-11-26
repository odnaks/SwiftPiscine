//
//  DetailPhotoController.swift
//  day03
//
//  Created by Kseniya Lukoshkina on 26.11.2020.
//

import UIKit

class DetailPhotoController: UIViewController {

    var photoImage: UIImage?
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        if let photo = photoImage {
            super.viewDidLoad()
            photoImageView.image = photo

//            scrollView.contentSize = (imageView.frame.size)
//                    scrollView.maximumZoomScale = 100
//                    scrollView.minimumZoomScale = 0.3
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
