//
//  AllPhotosController.swift
//  day03
//
//  Created by Kseniya Lukoshkina on 26.11.2020.
//

import UIKit

class AllPhotosController: UIViewController {
    
    private let photos = [
        "https://apod.nasa.gov/apod/image/2011/M31Horizon_Ferrarino_2048.jpg",
        "https://apod.nasa.gov/apod/image/2011/Helix2_CFHT_1917.jpg",
        "https://apod.nasa.gov/apod/image/2011/JupiterVista_JunoGill_3688.jpg",
        "https://apod.nasa.gov/apod/image/2011/LeonidmeteorandMarsoverYulongsnowmountain.jpg"
    ]
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
}

extension AllPhotosController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        DispatchQueue.global().async {[weak self] in
            if let stringUrl = self?.photos[indexPath.row], let url = URL(string: stringUrl) {
                print("\(indexPath.row) url ok")
                if let data = try? Data(contentsOf: url) {
                    print("\(indexPath.row) data ok")
                    if let image = UIImage(data: data) {
                        print("\(indexPath.row) image ok")
                        DispatchQueue.main.async {
                            cell.photoImageView.image = image
                        }
                    }
                }
            }
        }
        return cell
    }
    
    
}
