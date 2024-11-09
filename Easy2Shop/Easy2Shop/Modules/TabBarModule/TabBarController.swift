//
//  TabBarController.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 08.11.24.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let productsModule = ProductsViewController()
        let basketModule = BasketViewController()
        
        productsModule.tabBarItem = UITabBarItem(
            title: "All products",
            image: UIImage(systemName: "square.and.pencil"),
            tag: 0
        )
        
        basketModule.tabBarItem = UITabBarItem(
            title: "My basket",
            image: UIImage(systemName: "basket"),
            tag: 1
        )
        
        let controllers = [productsModule, basketModule]
        self.viewControllers = controllers.map { UINavigationController(rootViewController: $0) }
    }
}
