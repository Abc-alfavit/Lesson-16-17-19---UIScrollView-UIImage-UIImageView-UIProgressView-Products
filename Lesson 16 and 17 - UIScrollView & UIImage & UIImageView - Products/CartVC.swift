//
//  CartVC.swift
//  Lesson 16 and 17 - UIScrollView & UIImage & UIImageView - Products
//
//  Created by Валентин Ремизов on 05.03.2023.
//

import UIKit

class CartVC: UIViewController {
    let myLabel = UILabel(frame: CGRect(x: 100, y: 200, width: 200, height: 50))

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "bag"), tag: 3)
        myLabel.text = "Hi, buy and pay soon!"
        myLabel.textColor = .white
        view.addSubview(myLabel)
    }
}
