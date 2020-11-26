//
//  AllPhotosController.swift
//  day03
//
//  Created by Kseniya Lukoshkina on 26.11.2020.
//

import UIKit

class AllPhotosController: UIViewController {
    
    private let reuseIdentifier = "PhotoCollectionViewCell"
    private let inserts: CGFloat = 2
    private let countPhotoInRow: Int = 2
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    private var numberImageInProgress = 0
    private let photos = [
        "https://apod.nasa.gov/apod/image/2011/M31Horizon_Ferrarino_2048.jpg",
        "https://apod.nasa.gov/apod/image/2011/Helix2_CFHT_1917.jpg",
        "https://apod.nasa.gov/apod/image/2011/DoubleCluster_Polanski_4560.jpg",
        "https://apod.nasa.gov/apod/image/2011/SteveMilkyWay_NasaTrinder_6144.jpg",
       "https://apod.nasa.gov/apod/image/2011/CreteSky_Slovinsky_3000.jpg",
        "https://apod.nasa.gov/apod/image/2011/ngc5866_hst_1235.jpg",
        "https://apod.nasa.gov/apod/image/2011/lunaortybluenodidasc.jpg",
        "https://apod.nasa.gov/apod/image/2011/Tarantula_HOO_final_2_2048.jpg"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = inserts
        layout.minimumLineSpacing = inserts * 2
        photosCollectionView.collectionViewLayout = layout
        self.view.backgroundColor = .black
        
        self.title = "EARTH IS FLAT"
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    
    private func displayActivityndicator(_ state: Bool) {
        if #available(iOS 13, *) {} else {
            numberImageInProgress = state ? numberImageInProgress + 1 : numberImageInProgress - 1
            UIApplication.shared.isNetworkActivityIndicatorVisible = numberImageInProgress > 0 ? true : false
        }
    }
    
    private func showError(_ index: Int) {
        print("error")
        let alertVC = UIAlertController(title: "Error", message: "Cannot access to \(photos[index])", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: {_ in})
        alertVC.addAction(action)
        self.present(alertVC, animated: false)
    }
}

extension AllPhotosController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
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
                } else {
                    DispatchQueue.main.async {
                        cell.activityIndicator.stopAnimating()
                        self?.displayActivityndicator(false)
                        cell.photoImageView.image = UIImage(named: "errorImage")
                        self?.showError(indexPath.row)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    cell.activityIndicator.stopAnimating()
                    self?.displayActivityndicator(false)
                    cell.photoImageView.image = UIImage(named: "errorImage")
                    self?.showError(indexPath.row)
                }
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select \(indexPath.row)")
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailPhotoController") as! DetailPhotoController
        let cell = photosCollectionView.cellForItem(at: indexPath) as! PhotoCollectionViewCell
        vc.photoImage = cell.photoImageView.image
        self.show(vc, sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthView = Int(collectionView.frame.width)
        let widthCell = widthView / countPhotoInRow - Int(inserts) * 2
        
        return CGSize(width: widthCell, height: widthCell)
    }
}

