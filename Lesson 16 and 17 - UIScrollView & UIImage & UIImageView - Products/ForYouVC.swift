//
//  ForYouVC.swift
//  Lesson 16 and 17 - UIScrollView & UIImage & UIImageView - Products
//
//  Created by Валентин Ремизов on 05.03.2023.
//

import UIKit

class ForYouVC: UIViewController {
    let myLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem = UITabBarItem(title: "For you", image: UIImage(systemName: "person.crop.circle"), tag: 1)
        myLabel.text = "Но Вы мне не заплатили."
        myLabel.textColor = .white
        myLabel.frame = view.bounds
        myLabel.center = view.center
        myLabel.textAlignment = .center
        view.addSubview(myLabel)
    }
}
