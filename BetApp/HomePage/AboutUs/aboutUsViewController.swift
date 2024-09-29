//
//  aboutUsViewController.swift
//  BetApp
//
//  Created by Deniz Otlu on 21.09.2024.
//

import Foundation
import UIKit

class aboutUsViewController : UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
              title = "Detail"
              
              let label = UILabel()
              label.text = "test"
              label.textAlignment = .center
              view.addSubview(label)
              
              label.snp.makeConstraints { make in
                  make.center.equalToSuperview()
              }
    }
    
    
}
