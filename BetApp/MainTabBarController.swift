//
//  MainTabBarController.swift
//  BetApp
//
//  Created by Deniz Otlu on 18.09.2024.
//

import UIKit

class MainTabBarController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

       createTabbar()
        
    }
    
    
    func createTabbar() {
       
             let firstVC = ViewController()
             let firstNavController = UINavigationController(rootViewController: firstVC)
             firstNavController.tabBarItem = UITabBarItem(title: "Menü", image: UIImage(systemName: "house.fill"), tag: 0)
        firstVC.view.backgroundColor = .systemBackground
             
             let secondVC = BultenViewController()
             let secondNavController = UINavigationController(rootViewController: secondVC)
             secondNavController.tabBarItem = UITabBarItem(title: "Bülten", image: UIImage(systemName: "list.bullet"), tag: 1)
        secondVC.view.backgroundColor = .systemBackground
        
        
             viewControllers = [firstNavController, secondNavController]
    }
    
}



