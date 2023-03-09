//
//  SceneDelegate.swift
//  Lesson 16 and 17 - UIScrollView & UIImage & UIImageView - Products
//
//  Created by Валентин Ремизов on 05.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)

            let buyVC = BuyVC()
            let forYouVC = ForYouVC()
            let searchVC = SearchVC()
            let cartVC = CartVC()

            let searchNavController = UINavigationController(rootViewController: searchVC)
            //Создаём большой заголовок и назначаем белый цвет тексту заголовка, чтоб при переходе заголовок уходил анимацией в навигейшн бар.
//            searchVC.title = "Search"
//            UINavigationBar.appearance().prefersLargeTitles = true
//            UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
            let tabBarController = UITabBarController()
            //Этой строчкой мы устанавливаем первый загрузочный View
            tabBarController.setViewControllers([searchNavController], animated: true)
            //Этой строчкой создаем общее количество TabBar с ViewController'ами
            tabBarController.viewControllers = [buyVC, forYouVC, searchNavController, cartVC]
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

            self.window = window
            window.backgroundColor = .black
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()

        }
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

