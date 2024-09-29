//
//  ViewController.swift
//  BetApp
//
//  Created by Deniz Otlu on 18.09.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    var timer: Timer?
    var currentIndex = 0
    
    let api = NewsService()

    let button = UIButton()
    
    var articles : [Article] = []
      
      var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAutoScroll()

        
        navButton()
        setupCollectionView()
     
        api.fetchNews { result in
                    switch result {
                    case .success(let articles):
                        self.articles = articles
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    case .failure(let error):
                        print("Hata: \(error.localizedDescription)")
                    }
                }
        
       
    }
    func startAutoScroll() {
           timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
       }
    
    @objc func autoScroll() {
          if currentIndex < collectionView.numberOfItems(inSection: 0) {
              let indexPath = IndexPath(item: currentIndex, section: 0)
              collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
              currentIndex += 1
          } else {
              currentIndex = 0
          }
      }
    
        
        func navButton() {
            let ikon = UIImage(named: "betlogo")?.resized(to: CGSize(width: 100, height: 40))
            
            let leftButton = UIButton(type: .custom)
            leftButton.setImage(ikon, for: .normal)
            
            leftButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
            
            leftButton.addTarget(self, action: #selector(navigateToDetail), for: .touchUpInside)
            
            let leftBarButtonItem = UIBarButtonItem(customView: leftButton)
            navigationItem.leftBarButtonItem = leftBarButtonItem
            
            let rightButton = UIBarButtonItem(title: "Hakkımızda", style: .plain, target: self, action: #selector(navigateToDetail))
            navigationItem.rightBarButtonItem = rightButton
        }

    @objc func navigateToDetail() {
        
          let detailVC = aboutUsViewController()
          navigationController?.pushViewController(detailVC, animated: true)
        
      }
    
}



extension UIImage {
    func resized(to targetSize: CGSize) -> UIImage? {

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        let newSize = CGSize(width: size.width * widthRatio, height: size.height * heightRatio)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(origin: .zero, size: newSize))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}




extension ViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    private func setupCollectionView() {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        
        
            collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.isPagingEnabled = true
            collectionView.showsHorizontalScrollIndicator = true
          collectionView.backgroundColor = .black
            collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "BannerCell")
            
            view.addSubview(collectionView)
            
            collectionView.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
                make.left.equalToSuperview().inset(10)
                make.right.equalToSuperview().inset(10)
                make.height.equalTo(200)

            }
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return articles.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as? CollectionViewCell else {
                   return UICollectionViewCell()
               }

               let article = articles[indexPath.row]
               cell.configure(with: article)
               return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    
       
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let selectedBanner = articles[indexPath.row]
            
            
            let bannerDetail = BannerDetailView()
            bannerDetail.article = selectedBanner
            
            let navigationController = UINavigationController(rootViewController: bannerDetail)
            navigationController.modalPresentationStyle = .popover
            present(navigationController, animated: true, completion: nil)
            
            
            
        }
    
    
    
    }

    
    
    






#Preview{
    MainTabBarController()
}


