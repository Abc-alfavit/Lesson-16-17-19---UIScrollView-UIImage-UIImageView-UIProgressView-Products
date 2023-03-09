//
//  ViewController.swift
//  Lesson 16 and 17 - UIScrollView & UIImage & UIImageView - Products
//
//  Created by Валентин Ремизов on 05.03.2023.
//

import UIKit

class BuyVC: UIViewController {
    let myLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem = UITabBarItem(title: "Buy", image: UIImage(systemName: "macbook.and.iphone"), tag: 0)
        myLabel.text = "Здесь могла быть Ваша реклама."
        myLabel.textColor = .white
        myLabel.frame = view.bounds
        myLabel.center = view.center
        myLabel.textAlignment = .center
        view.addSubview(myLabel)
    }


}

