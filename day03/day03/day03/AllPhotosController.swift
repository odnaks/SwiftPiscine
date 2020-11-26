//
//  AllPhotosController.swift
//  day03
//
//  Created by Kseniya Lukoshkina on 26.11.2020.
//

import UIKit

class AllPhotosController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var numberImageInProgress = 0
    private let photos = [
        "https://apod.nasa.gov/apod/image/2011/M31Horizon_Ferrarino_2048.jpg",
        "https://apod.nasa.gov/apod/image/2011/Helix2_CFHT_1917.jpg",
        "https://apod.nasa.gov/apod/image/2011/JupiterVista_JunoGill_3688.jpg",
        "https://apod.nasa.gov/apod/image/2011/LeonidmeteorandMarsoverYulongsnowmountain.jpg",
        "https://apod.nasa.gov/apod/image/2011/DoubleCluster_Polanski_4560.jpg",
        "https://apod.nasa.gov/apod/image/2011/SteveMilkyWay_NasaTrinder_6144.jpg",
//        "https://apod.nasa.gov/apod/image/2011/CreteSky_Slovinsky_3000.jpg",
//        "https://apod.nasa.gov/apod/image/2011/ngc5866_hst_1235.jpg",
//        "https://apod.nasa.gov/apod/image/2011/lunaortybluenodidasc.jpg",
//        "https://apod.nasa.gov/apod/image/2011/Tarantula_HOO_final_2_2048.jpg"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func displayActivityndicator(_ state: Bool) {
        if #available(iOS 13, *) {} else {
            numberImageInProgress = state ? numberImageInProgress + 1 : numberImageInProgress - 1
            UIApplication.shared.isNetworkActivityIndicatorVisible = numberImageInProgress > 0 ? true : false
        }
    }
}

extension AllPhotosController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        cell.activityIndicator.startAnimating()
        displayActivityndicator(true)
        DispatchQueue.global().async {[weak self] in
            if let stringUrl = self?.photos[indexPath.row], let url = URL(string: stringUrl) {
                print("\(indexPath.row) url ok")
                if let data = try? Data(contentsOf: url) {
                    print("\(indexPath.row) data ok")
                    if let image = UIImage(data: data) {
                        print("\(indexPath.row) image ok")
                        DispatchQueue.main.async {
                            cell.photoImageView.image = image
                            cell.activityIndicator.stopAnimating()
                            self?.displayActivityndicator(false)
                        }
                    }
                }
            }
        }
        return cell
    }
    
    
}
