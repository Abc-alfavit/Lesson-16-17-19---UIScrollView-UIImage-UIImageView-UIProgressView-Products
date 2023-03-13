//
//  ForYouVC.swift
//  Lesson 16 and 17 - UIScrollView & UIImage & UIImageView - Products
//
//  Created by Валентин Ремизов on 05.03.2023.
//

import UIKit

final class ForYouVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private let forYouLabel = UILabel()
    private let avatarImageView = UIImageView()
    private let defaults = UserDefaults.standard
    private let whatNew = UILabel()
    private let viewPlace = UIView()
    private let productImageView = UIImageView(image: UIImage(named: "iphone"))
    private let statusOfOrderLabel = UILabel()
    private let countAndDeliveryLabel = UILabel()
    private let chevronRightImageView = UIImageView(image: UIImage(systemName: "chevron.forward"))
    private let orderProgressView = UIProgressView()
    private let startStatusLabel = UILabel()
    private let midStatusLabel = UILabel()
    private let finishStatusLabel = UILabel()
    private let recommendedLabel = UILabel()
    private let recommendedImageView = UIImageView(image: UIImage(systemName: "app.badge"))
    private let titleNews = UILabel()
    private let desriptionNews = UILabel()
    private let chevronRightForRecommendedImageView = UIImageView(image: UIImage(systemName: "chevron.forward"))
    private let yourDevicesLabel = UILabel()
    private let showAll = UIButton()
    private let picker = UIImagePickerController()


    override internal func viewDidAppear(_ animated: Bool) {
        //Почему-то во ViewDidLoad не работает это, поэтому делаю здесь.
        let navBar = self.navigationController?.navigationBar
        //Возвращаем обратно обычный бар (без увеличенного заголовка)
        navBar?.prefersLargeTitles = false
        //Меняем фон у navigationBar
        navBar?.backgroundColor = nil
        //Меняем фон у statusBar
        let statusBarView = UIView(frame: view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
        statusBarView.backgroundColor = nil
        view.backgroundColor = .white
        view.addSubview(statusBarView)
        tabBarController?.tabBar.barTintColor = .green
    }
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem = UITabBarItem(title: "For you",
                                  image: UIImage(systemName: "person.crop.circle"),
                                  tag: 1)
        createForYouLabel()
        createAvatar()
        createWhatNewLabel()
        createViewOfOrder()
        createRecommendedLabel()
        createRecommendedImage()
        createTitleNews()
        createDesriptionNews()
        createChevronForRecommended()
        createYourDevicesLabel()
        createShowAllButton()
        picker.delegate = self
    }

    //Создание лейбла "Для Вас"
    private func createForYouLabel() {
        forYouLabel.frame = CGRect(x: 20,
                                   y: 95,
                                   width: view.frame.width - 40,
                                   height: 70)
        forYouLabel.text = "For you"
        forYouLabel.font = UIFont(name: "HelveticaNeue-Bold",
                                  size: 35)
        let line = CALayer()
        line.frame = CGRect(x: forYouLabel.bounds.minX,
                            y: forYouLabel.bounds.maxY,
                            width: forYouLabel.frame.width,
                            height: 1)
        line.backgroundColor = UIColor.systemGray5.cgColor
        forYouLabel.layer.addSublayer(line)
        view.addSubview(forYouLabel)
    }

    //Создание аватара
    private func createAvatar() {
        avatarImageView.frame = CGRect(x: forYouLabel.frame.maxX - 50,
                                       y: 0,
                                       width: 50,
                                       height: 50)
        avatarImageView.center.y = forYouLabel.frame.midY

//MARK: - Загрузка аватарки
        if (UserDefaults.standard.object(forKey: "Avatar") as? NSData) != nil {
            let photo = UserDefaults.standard.object(forKey: "Avatar") as! NSData
            avatarImageView.image = UIImage(data: photo as Data)
        } else {
            avatarImageView.image = UIImage(systemName: "questionmark.circle.fill")
            avatarImageView.tintColor = .lightGray
        }
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        avatarImageView.clipsToBounds = true

        //Делаем тап для реагирования нажатия на аватарку
        let tap = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tap)
        view.addSubview(avatarImageView)
    }

//Функция срабатывания тапа
    @objc private func avatarTapped() {
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }

//UIImagePickerControllerDelegate, UINavigationControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let defaults = UserDefaults.standard
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        avatarImageView.image = image
        let saveImage = image.pngData() as NSData?
        //Сохраняем изображение в UserDefaults
        defaults.set(saveImage, forKey: "Avatar")
        picker.dismiss(animated: true)
    }

    //Создание лейбла "вот что нового"
    private func createWhatNewLabel() {
        whatNew.text = "Here what is new"
        whatNew.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        whatNew.frame = CGRect(x: forYouLabel.frame.minX,
                               y: forYouLabel.frame.maxY + 30,
                               width: forYouLabel.bounds.width,
                               height: forYouLabel.bounds.height - 10)
        view.addSubview(whatNew)
    }

//MARK: - Создаем view с заказом
    private func createViewOfOrder() {
        viewPlace.frame = CGRect(x: whatNew.frame.minX,
                                 y: whatNew.frame.maxY + 20,
                                 width: whatNew.bounds.width,
                                 height: 150)
        viewPlace.backgroundColor = .white
        viewPlace.layer.cornerRadius = 15
        viewPlace.layer.shadowOffset = CGSize(width: 7, height: 7)
        viewPlace.layer.shadowRadius = 10
        viewPlace.layer.shadowColor = UIColor.lightGray.cgColor
        viewPlace.layer.shadowOpacity = 0.4
        view.addSubview(viewPlace)

        //Картинка заказа
        productImageView.frame = CGRect(x: 20,
                                    y: 20,
                                    width: 50,
                                    height: 50)
        productImageView.contentMode = .scaleAspectFit
        viewPlace.addSubview(productImageView)

        //Разделительная линия
        let lineLayer = CALayer()
        lineLayer.frame = CGRect(x: 0,
                            y: productImageView.frame.maxY + productImageView.frame.minY,
                            width: viewPlace.bounds.width,
                            height: 1)
        lineLayer.backgroundColor = UIColor.systemGray5.cgColor
        viewPlace.layer.addSublayer(lineLayer)

        //Название статуса заказа
        statusOfOrderLabel.frame = CGRect(x: productImageView.frame.maxX + 10,
                                                  y: productImageView.frame.midY - 25,
                                                  width: viewPlace.bounds.width - productImageView.frame.maxX - 40,
                                                  height: 25)
        statusOfOrderLabel.text = "Your order sended"
        statusOfOrderLabel.font = .boldSystemFont(ofSize: 16)
        viewPlace.addSubview(statusOfOrderLabel)

        //Количество товара и когда доставка
        countAndDeliveryLabel.frame = CGRect(x: statusOfOrderLabel.frame.minX,
                                                            y: statusOfOrderLabel.frame.maxY,
                                                            width: statusOfOrderLabel.bounds.width,
                                                            height: statusOfOrderLabel.bounds.height)
        countAndDeliveryLabel.text = "1 product, delivery is tomorrow"
        countAndDeliveryLabel.textColor = .lightGray
        countAndDeliveryLabel.font = .systemFont(ofSize: 16)
        viewPlace.addSubview(countAndDeliveryLabel)

        //Стрелка вправо
        chevronRightImageView.contentMode = .scaleAspectFit
        chevronRightImageView.frame = CGRect(x: statusOfOrderLabel.frame.maxX,
                                             y: 0,
                                             width: 20, height: 20)
        chevronRightImageView.center.y = productImageView.frame.midY
        chevronRightImageView.tintColor = .lightGray
        viewPlace.addSubview(chevronRightImageView)

        //UIProgressView заказа
        orderProgressView.frame = CGRect(x: productImageView.frame.minX,
                                                           y: lineLayer.frame.maxY + 15,
                                                           width: viewPlace.bounds.width - (productImageView.frame.minX * 2),
                                                           height: 10)
        //Увеличивает наш UI, в значениях указывается во сколько раз увеличить.
        orderProgressView.transform = orderProgressView.transform.scaledBy(x: 1, y: 2)
        orderProgressView.setProgress(0.5, animated: true)
        orderProgressView.trackTintColor = .systemGray5
        orderProgressView.progressTintColor = .systemGreen
        viewPlace.addSubview(orderProgressView)

        //Статус "Обработан"
        startStatusLabel.frame = CGRect(x: orderProgressView.frame.minX,
                                                     y: orderProgressView.frame.maxY + 10,
                                                     width: orderProgressView.frame.width / 3,
                                                     height: 18)
        startStatusLabel.text = "Processed"
        startStatusLabel.font = .boldSystemFont(ofSize: 14)
        viewPlace.addSubview(startStatusLabel)

        //Статус "отправлен"
        midStatusLabel.frame = CGRect(x: 0,
                                                  y: orderProgressView.frame.maxY + 10,
                                                  width: orderProgressView.frame.width / 3,
                                                  height: 18)
        midStatusLabel.center.x = orderProgressView.center.x
        midStatusLabel.textAlignment = .center
        midStatusLabel.text = "Sended"
        midStatusLabel.font = .boldSystemFont(ofSize: 14)
        viewPlace.addSubview(midStatusLabel)

        //Статус "Доставлен"
        finishStatusLabel.frame = CGRect(x: orderProgressView.frame.maxX - (orderProgressView.frame.width / 3),
                                                      y: orderProgressView.frame.maxY + 10,
                                                      width: orderProgressView.frame.width / 3,
                                                      height: 18)

        finishStatusLabel.text = "Delivered"
        finishStatusLabel.textAlignment = .right
        finishStatusLabel.font = .boldSystemFont(ofSize: 14)
        viewPlace.addSubview(finishStatusLabel)
    }

    //Создание "Рекомендуется Вам"
    private func createRecommendedLabel() {
        recommendedLabel.frame = CGRect(x: viewPlace.frame.minX,
                                        y: viewPlace.frame.maxY + 30,
                                        width: viewPlace.bounds.width,
                                        height: forYouLabel.bounds.height - 15)
        recommendedLabel.text = "Recommended to you"
        recommendedLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        view.addSubview(recommendedLabel)
    }

    //Создание "Рекомендуется Вам" картинка
    private func createRecommendedImage() {
        recommendedImageView.frame = CGRect(x: recommendedLabel.frame.minX + 10,
                                            y: recommendedLabel.frame.maxY + 15,
                                            width: 50,
                                            height: 50)
        recommendedImageView.contentMode = .scaleAspectFit
        recommendedImageView.tintColor = .systemPink
        view.addSubview(recommendedImageView)
    }

    //Создание "Получайте новости о Вашем заказе в режиме реального времени"
    private func createTitleNews() {
        titleNews.frame = CGRect(x: recommendedImageView.frame.maxX + 20,
                                 y: recommendedImageView.frame.minY,
                                 width: view.frame.width - recommendedImageView.frame.maxX - 60,
                                 height: 50)
        titleNews.text = "Get news about your order in mode live time."
        titleNews.numberOfLines = 0
        titleNews.font = statusOfOrderLabel.font
        view.addSubview(titleNews)
    }

    //Создание "Включите уведомления, чтобы получать новости о Вашем заказе"
    private func createDesriptionNews() {
        desriptionNews.frame = CGRect(x: titleNews.frame.minX,
                                      y: titleNews.frame.maxY,
                                      width: titleNews.frame.width,
                                      height: titleNews.frame.height)
        desriptionNews.text = "Turn on is notifications, to will get news about yourself order."
        desriptionNews.textColor = .lightGray
        desriptionNews.numberOfLines = 0
        desriptionNews.font = .systemFont(ofSize: 16)

        //Разделительная линия
        let line = CALayer()
        line.frame = CGRect(x: recommendedLabel.frame.minX,
                            y: desriptionNews.frame.maxY + 20,
                            width: recommendedLabel.frame.width,
                            height: 1)
        line.backgroundColor = UIColor.systemGray5.cgColor
        view.layer.addSublayer(line)
        view.addSubview(desriptionNews)
    }

    //Создание стрелки вправо
    private func createChevronForRecommended() {
        chevronRightForRecommendedImageView.frame = CGRect(x: titleNews.frame.maxX,
                                                           y: 0,
                                                           width: 20,
                                                           height: 20)
        chevronRightForRecommendedImageView.center.y = titleNews.frame.maxY
        chevronRightForRecommendedImageView.tintColor = .lightGray
        chevronRightForRecommendedImageView.contentMode = .scaleAspectFit
        view.addSubview(chevronRightForRecommendedImageView)
    }

    //Создание "Ваши устройства"
    private func createYourDevicesLabel() {
        yourDevicesLabel.frame = CGRect(x: recommendedLabel.frame.minX,
                                        y: desriptionNews.frame.maxY + 41,
                                        width: recommendedLabel.frame.width - 70,
                                        height: whatNew.frame.height)
        yourDevicesLabel.text = "Your devices"
        yourDevicesLabel.font = whatNew.font
        view.addSubview(yourDevicesLabel)
    }

    //Создание "Показать все"
    private func createShowAllButton() {
        showAll.frame = CGRect(x: recommendedLabel.frame.maxX - 70,
                               y: 0,
                               width: 70,
                               height: 20)
        showAll.center.y = yourDevicesLabel.center.y
        showAll.setTitle("Show all", for: .normal)
        showAll.setTitleColor(.blue, for: .normal)
        showAll.titleLabel?.font = .systemFont(ofSize: 18)
        view.addSubview(showAll)
    }
}


