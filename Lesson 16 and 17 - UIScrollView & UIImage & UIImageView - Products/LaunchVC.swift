//
//  LaunchVC.swift
//  Lesson 16 and 17 - UIScrollView & UIImage & UIImageView - Products
//
//  Created by Валентин Ремизов on 11.03.2023.
//

import UIKit

class LaunchVC: UIViewController {
    private let launchProgressView = UIProgressView()
    private let appleImageView = UIImageView(image: UIImage(systemName: "apple.logo"))
    private var timer = Timer()

    internal override func viewDidLoad() {
        super.viewDidLoad()
        createLaunchProgressView()
        createAppleImageView()
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(createTargetTimer),
                                     userInfo: nil,
                                     repeats: true)
    }

    @objc private func createTargetTimer() {
        if launchProgressView.progress != 1 {
            launchProgressView.progress += 0.2
        } else if launchProgressView.progress == 1 {
            launchProgressView.isHidden = true
            UIView.animate(withDuration: 2) {
                self.appleImageView.alpha = 1
                self.timer.invalidate()
            }
//MARK: - Отложенный запуск кода, срабатывает через 2 секунды в этом случае (указывается в скобках)
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                //Здесь указывается код, который нужно исполнить по прошествии этого времени
                self.createAllApp()
            }
        }
    }

    fileprivate func createLaunchProgressView() {
        launchProgressView.frame = CGRect(x: 0,
                                          y: 0,
                                          width: view.frame.width - 80,
                                          height: 20)
        launchProgressView.progressViewStyle = .default
        launchProgressView.setProgress(0, animated: true)
        launchProgressView.center = view.center
        launchProgressView.tintColor = .white
        launchProgressView.trackTintColor = .black
        view.addSubview(launchProgressView)
    }

    fileprivate func createAppleImageView() {
        appleImageView.frame = CGRect(x: 0,
                                      y: view.center.y - 100,
                                      width: 70,
                                      height: 70)
        appleImageView.tintColor = .white
        appleImageView.contentMode = .scaleAspectFit
        appleImageView.center.x = view.center.x
        appleImageView.alpha = 0
        view.addSubview(appleImageView)
    }

    private func createAllApp() {
        let buyVC = BuyVC()
        let forYouVC = ForYouVC()
        let searchVC = SearchVC()
        let cartVC = CartVC()

        let searchNavController = UINavigationController(rootViewController: searchVC)
        let tabBarVC = UITabBarController()
        //Этой строчкой мы устанавливаем первый загрузочный View
        tabBarVC.setViewControllers([searchNavController],
                                            animated: true)
        //Этой строчкой создаем общее количество TabBar с ViewController'ами
        tabBarVC.viewControllers = [buyVC, forYouVC,
                                            searchNavController, cartVC]
        //Назначаем цвет для текущей страницы меню TabBar
        UITabBar.appearance().tintColor = .systemBlue
        //Назначаем цвет для невыбранных страниц в меню TabBar
        UITabBar.appearance().barTintColor = .lightGray
        //Назначаем цвет фона для меню TabBar
        UITabBar.appearance().backgroundColor = .tertiaryLabel
        //Подгружаем картинки и названия других TabBar'ов, а то видно не будет их.
        forYouVC.loadViewIfNeeded()
        buyVC.loadViewIfNeeded()
        cartVC.loadViewIfNeeded()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate,
            let window = sceneDelegate.window {
            window.rootViewController = tabBarVC
            window.makeKeyAndVisible()
        }

    }
}
