//
//  BannerDetailView.swift
//  BetApp
//
//  Created by Deniz Otlu on 28.09.2024.
//

import Foundation
import UIKit
import SnapKit

class BannerDetailView : UIViewController {
    
    var article : Article?
    
    private var descriptionZone = UITextView()
    private var BannerImage = UIImageView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Kapat", style: .plain, target: self, action: #selector(dismissModal))
        
        let fullTitle = article?.title
        let word = fullTitle?.components(separatedBy: " ")
        let firtTheree = word?.prefix(4).joined(separator: " ")
        navigationItem.title = firtTheree
        
        textInput()
        CreateImage()
        DetailConstraint()
    }

    @objc func dismissModal() {
            dismiss(animated: true, completion: nil)
        }
    
    
    func CreateImage(){
        
        BannerImage.backgroundColor = .black
        view.addSubview(BannerImage)
        
        if let imageUrlString = article?.urlToImage, 
            let imageUrl = URL(string: imageUrlString) {
                    BannerImage.load(url: imageUrl)
                }
       
        
    }
    
    func textInput(){
        let desc = article?.description
        view.addSubview(descriptionZone)
        descriptionZone.backgroundColor = .systemBackground
        descriptionZone.text = desc
        descriptionZone.font = UIFont.systemFont(ofSize: 20)
        descriptionZone.isScrollEnabled = true
    }
    
   

    func DetailConstraint() {
    
        BannerImage.snp.makeConstraints { make in
            
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview().inset(1)
            make.bottom.equalToSuperview().inset(500)
        }
        
        
        descriptionZone.snp.makeConstraints { make in
               make.top.equalTo(BannerImage.snp.bottom).offset(10)
               make.left.right.equalToSuperview().inset(1)
               make.bottom.equalToSuperview()
         }
        
      }
    
    
  
    
    
}


#Preview{
    MainTabBarController()
}
