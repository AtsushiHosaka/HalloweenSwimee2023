//
//  ViewController.swift
//  HalloweenSwimee2023
//
//  Created by 保坂篤志 on 2023/10/29.
//

import UIKit

class ViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard
    
    var fileNames = [String]()
    var data = [PictureData]()
    
    @IBOutlet weak var noPostLabel: UILabel!
    @IBOutlet weak var noPostImage: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var photoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "PictureCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        
        collectionView.collectionViewLayout = layout
        
        photoButton.layer.cornerRadius = photoButton.bounds.height / 2
        
        userDefaults.register(defaults: ["fileNames": [String]()])
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.8
        animation.repeatCount = Float.infinity
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: noPostImage.center.x, y: noPostImage.center.y - 10))
        animation.toValue = NSValue(cgPoint: CGPoint(x: noPostImage.center.x, y: noPostImage.center.y + 10))
        noPostImage.layer.add(animation, forKey: "position")
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.duration = 1.0
        opacityAnimation.autoreverses = true
        opacityAnimation.fromValue = 1.0
        opacityAnimation.toValue = 0.5
        opacityAnimation.repeatCount = Float.infinity
        noPostImage.layer.add(opacityAnimation, forKey: "opacity")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fileNames = userDefaults.array(forKey: "fileNames") as! [String]
        
        if fileNames.isEmpty {
            
            noPostLabel.isHidden = false
            noPostImage.isHidden = false
        }else {
            
            noPostLabel.isHidden = true
            noPostImage.isHidden = true
        }
        
        collectionView.reloadData()
    }
    
    @IBAction func takePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            
            picker.allowsEditing = true
            
            present(picker, animated: true)
        }
    }
    
    func showAlert(title: String, message: String? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true)
    }
    
    func appendImageName(newFileName: String) {
        guard var fileNames = userDefaults.array(forKey: "fileNames") as? [String] else { return }
        
        fileNames.append(newFileName)
        
        userDefaults.set(fileNames, forKey: "fileNames")
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else {
            showAlert(title: "写真が保存できませんでした")
            return
        }
        
        let fileName = UUID().uuidString
        
        ImageManager.shared.store(image: image, forKey: fileName)
        appendImageName(newFileName: fileName)
        
        dismiss(animated: true)
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return fileNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PictureCollectionViewCell
        
        let image = ImageManager.shared.retrieveImage(forKey: fileNames[indexPath.row])
        
        let random = Int.random(in: 0..<8)
        
        if random < 4 {
            if random < 2 {
                cell.obakeImage.setImage(UIImage(named: "obake"), for: .normal)
                
            } else {
                cell.obakeImage.setImage(UIImage(named: "five"), for: .normal)
            }
            
            cell.obakeImage.setTitle("", for: .normal)
            cell.obakeImage.center = CGPoint(x: CGFloat.random(in: 40...80), y: CGFloat.random(in: 40...80))
            
        }
        
        cell.imageView.image = image
        
        
        cell.layer.cornerCurve = .continuous
        cell.layer.cornerRadius = 15
        
        cell.imageView.layer.cornerCurve = .continuous
        cell.imageView.layer.cornerRadius = 10
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
}
