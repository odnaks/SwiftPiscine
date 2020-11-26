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
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        scrollView.delegate = self
        if let photo = photoImage {
            super.viewDidLoad()
            photoImageView.image = photo
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.setMinZoomScaleForImageSize()
    }
    
    private func setMinZoomScaleForImageSize() {
        
        guard let photo = photoImage else {return}
        
        let widthScale = view.frame.width / photo.size.width
        let heightScale = view.frame.height / photo.size.height
        var minScale = min(widthScale, heightScale)
        if UIDevice.current.orientation.isLandscape {
            minScale = max(widthScale, heightScale)
        } else {
            minScale = min(widthScale, heightScale)
        }
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
        scrollView.delegate = self as UIScrollViewDelegate
        scrollView.bounds = self.view.bounds

        let imageWidth = photo.size.width * minScale
        let imageHeight = photo.size.height * minScale
        let newImageFrame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        photoImageView.frame = newImageFrame

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        setMinZoomScaleForImageSize()
    }
    
}

extension DetailPhotoController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }

}
