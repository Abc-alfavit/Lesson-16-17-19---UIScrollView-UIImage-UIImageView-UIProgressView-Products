//
//  SearchVC.swift
//  Lesson 16 and 17 - UIScrollView & UIImage & UIImageView - Products
//
//  Created by Валентин Ремизов on 05.03.2023.
//

import UIKit

class SearchVC: UIViewController {
    private let searchStringTF = UITextField()
    private let searchImageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
    //3. Чтобы выставить отступ для картинки у UIView координаты оставляем 0, но ширину делаем больше, чем размер картинки, а высоту такую же.
    private let searchView = UIView(frame: CGRect(x: 0,
                                          y: 0,
                                          width: 30,
                                          height: 20))
    private let recentlyViewedLabel = UILabel(frame: CGRect(x: 10,
                                                            y: 200,
                                                            width: 250,
                                                            height: 40))
    private let clearButton = UIButton()
    private let productsScrollView = UIScrollView()
    private let queryOptions = UILabel(frame: CGRect(x: 10,
                                                     y: 500,
                                                     width: 300,
                                                     height: 40))
    private let requestAirpodsTF = UITextField()
    private let requestAppleCareTF = UITextField()
    private let requestBeatsTF = UITextField()
    private let requestCompareModelsIphoneTF = UITextField()
    private let descriptionArray = ["Grid pattern case for Macbook Pro 16\"",
                                    "Sports strap Black Unity (for Apple Watch)",
                                    "Leather case for Macbook Pro 16 inches",
                                    "iPhone 14 Pro 512Gb"]
    private let priceArray = ["490$", "220$", "830$", "990$"]

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = "Search"
        //Почему-то во ViewDidLoad не работает это, поэтому делаю здесь.
        let navBar = self.navigationController?.navigationBar
        //Делаем бар с большим заголовком
        navBar?.prefersLargeTitles = true
        navBar?.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem = UITabBarItem(title: "Search",
                                  image: UIImage(systemName: "magnifyingglass"),
                                  tag: 2)
        createSearchTF()
        createRecentlyViewedLabel()
        createClearButton()
        createScrollView()
        createQueryOptions()
        createRequestOne(nameRequest: "AirPods", textField: requestAirpodsTF, numberPosition: 1)
        createRequestOne(nameRequest: "Apple Care", textField: requestAppleCareTF, numberPosition: 2)
        createRequestOne(nameRequest: "Beats", textField: requestBeatsTF, numberPosition: 3)
        createRequestOne(nameRequest: "Compare models iPhone", textField: requestCompareModelsIphoneTF, numberPosition: 4)
        [searchStringTF, recentlyViewedLabel, clearButton,
         productsScrollView, queryOptions].forEach{view.addSubview($0)}
    }

    fileprivate func createSearchTF() {
        searchStringTF.frame = CGRect(x: 10,
                                      y: 150,
                                      width: view.bounds.width - 20,
                                      height: 34)
        searchStringTF.textColor = .white
        createSearchImageInsideTF(textField: searchStringTF, view: searchView, imageView: searchImageView)
        searchStringTF.placeholder = "Enter your request"
        //Назначаем цвет placeholder
        searchStringTF.attributedPlaceholder = NSAttributedString(string: "Enter your request",
                                                                  attributes: [NSAttributedString.Key.foregroundColor :
                                                                                UIColor.lightGray])
        searchStringTF.borderStyle = .roundedRect
        searchStringTF.backgroundColor = .secondaryLabel
    }

//MARK: - создаем лупу в окне textField (универсальная функция)
    fileprivate func createSearchImageInsideTF(textField: UITextField,
                                               view: UIView,
                                               imageView: UIImageView) {
        //1. Чтобы создать картинку нужно для UITextField поставить режим в .always
        textField.leftViewMode = .always
        //2. Потом создаем картинку и указываем у неё в X отступ от левого края, но чтоб это сработало нужен ещё UIView (смотрите вверху где создание глобальных констант)
        imageView.frame = CGRect(x: 10, y: 0, width: 20, height: 20)
        imageView.tintColor = .lightGray
        imageView.contentMode = .center
        //4. Теперь кладём нашу картинку в саму UIView. Итого: картинка отступает на 10 от края самой UIView, но сама UIView упирается в край TF, но ширина её больше, таким картинка смещается к правому краю UIView и создается колхозный отступ, но выглядит всё как с завода))
        //Дай Бог здоровья комментаторам в этой теме по этому вопросу: https://stackoverflow.com/questions/27903500/swift-add-icon-image-in-uitextfield
        view.addSubview(imageView)
        textField.leftView = view
    }

    fileprivate func createRecentlyViewedLabel() {
        recentlyViewedLabel.text = "Recently viewed"
        recentlyViewedLabel.font = UIFont.boldSystemFont(ofSize: 25)
        recentlyViewedLabel.textAlignment = .left
        recentlyViewedLabel.textColor = .white
    }

    fileprivate func createClearButton() {
        clearButton.frame = CGRect(x: Int(view.bounds.width - 120),
                                   y: 200,
                                   width: 100,
                                   height: 34)
        clearButton.setTitle("Clear", for: .normal)
        clearButton.setTitleColor(.systemBlue, for: .normal)
        clearButton.contentHorizontalAlignment = .right
        clearButton.contentVerticalAlignment = .bottom
        clearButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
    }

    private func createScrollView() {
        productsScrollView.frame = CGRect(x: 10,
                                          y: 260,
                                          width: view.bounds.width,
                                          height: 200)
        productsScrollView.backgroundColor = .black
        productsScrollView.indicatorStyle = .black
        //Создаем и извлекаем опционал из UIImage
        guard let img1 = UIImage(named: "case") else { return }
        //Передаем в функцию меняющиеся параметры и вся магие происходит в этой функции, быстро и вжух у тебя новый элемент уже)
        createFullElements(img: img1, description: descriptionArray[0], numberPosition: 1)
        guard let img2 = UIImage(named: "strap") else { return }
        createFullElements(img: img2, description: descriptionArray[1], numberPosition: 2)
        guard let img3 = UIImage(named: "case2") else { return }
        createFullElements(img: img3, description: descriptionArray[2], numberPosition: 3)
        guard let img4 = UIImage(named: "iphone") else { return }
        createFullElements(img: img4, description: descriptionArray[3], numberPosition: 4)
    }

//MARK: - Создаем галерею товаров из ScrollView (универсальная функция)
    fileprivate func createFullElements(img: UIImage,
                                        description: String,
                                        numberPosition: Int) {
        let currentImageView = UIImageView(image: img)
        currentImageView.frame = CGRect(x: 20,
                                        y: 20,
                                        width: 110,
                                        height: 100)
        currentImageView.contentMode = .scaleAspectFit
        let label = UILabel()
        label.text = description
        label.textColor = .white
        label.frame = CGRect(x: 7,
                             y: 130,
                             width: 136,
                             height: 50)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.font = .boldSystemFont(ofSize: 14)
        let view = UIView()
        view.frame = CGRect(x: 160 * (numberPosition - 1),
                            y: 0,
                            width: 150,
                            height: 190)
        view.addSubview(currentImageView)
        view.addSubview(label)
        view.backgroundColor = .secondaryLabel
        view.layer.cornerRadius = view.bounds.height / 12
        productsScrollView.contentSize = CGSize(width: 160 * numberPosition,
                                                height: 190)
        productsScrollView.addSubview(view)
        view.isUserInteractionEnabled = true
        if numberPosition == 1 {
            let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                           action: #selector(transitionTagZero))
            view.addGestureRecognizer(gestureRecognizer)
        } else if numberPosition == 2 {
            let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                           action: #selector(transitionTagOne))
            view.addGestureRecognizer(gestureRecognizer)
        } else if numberPosition == 3 {
            let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                           action: #selector(transitionTagTwo))
            view.addGestureRecognizer(gestureRecognizer)
        } else {
            let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                           action: #selector(transitionTagThree))
            view.addGestureRecognizer(gestureRecognizer)
        }
    }

    @objc private func transitionTagZero() {
        transitionToSecondPage(tag: 0)
    }

    @objc private func transitionTagOne() {
        transitionToSecondPage(tag: 1)
    }

    @objc private func transitionTagTwo() {
        transitionToSecondPage(tag: 2)
    }

    @objc private func transitionTagThree() {
        transitionToSecondPage(tag: 3)
    }


    private func transitionToSecondPage(tag: Int) {
        let infoProduct = InfoProduct()
        if tag == 0 {
            infoProduct.nameProductLabel.text = descriptionArray[0]
            infoProduct.nameProductDuplicateLabel.text = descriptionArray[0]
            infoProduct.priceProductLabel.text = priceArray[0]
            infoProduct.createImageScrollView(tag: 0)
            navigationController?.pushViewController(infoProduct, animated: true)
        } else if tag == 1 {
            infoProduct.nameProductLabel.text = descriptionArray[1]
            infoProduct.nameProductDuplicateLabel.text = descriptionArray[1]
            infoProduct.priceProductLabel.text = priceArray[1]
            infoProduct.createImageScrollView(tag: 1)
            navigationController?.pushViewController(infoProduct, animated: true)
        } else if tag == 2 {
            infoProduct.nameProductLabel.text = descriptionArray[2]
            infoProduct.nameProductDuplicateLabel.text = descriptionArray[2]
            infoProduct.priceProductLabel.text = priceArray[2]
            infoProduct.createImageScrollView(tag: 2)
            navigationController?.pushViewController(infoProduct, animated: true)
        } else if tag == 3 {
            infoProduct.nameProductLabel.text = descriptionArray[3]
            infoProduct.nameProductDuplicateLabel.text = descriptionArray[3]
            infoProduct.priceProductLabel.text = priceArray[3]
            infoProduct.createImageScrollView(tag: 3)
            navigationController?.pushViewController(infoProduct, animated: true)
        }
    }

    fileprivate func createQueryOptions() {
        queryOptions.text = "Query options"
        queryOptions.font = UIFont.boldSystemFont(ofSize: 25)
        queryOptions.textAlignment = .left
        queryOptions.textColor = .white
    }

//MARK: - Создаем варианты запросов. Универсальная функция, почти:)
    fileprivate func createRequestOne(nameRequest: String,
                                      textField: UITextField,
                                      numberPosition: Int) {
        textField.frame = CGRect(x: 10,
                                 y: 550 + ((numberPosition - 1) * 45),
                                 width: Int(view.bounds.width) - 20,
                                 height: 34)
        textField.textColor = .white
        let requestSearchImageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        let requestsSearchView = UIView(frame: CGRect(x: 0,
                                                              y: 0,
                                                              width: 40,
                                                              height: 20))
        createSearchImageInsideTF(textField: textField, view: requestsSearchView, imageView: requestSearchImageView)
        textField.text = nameRequest
        //Назначаем цвет placeholder, размер и толщину шрифта
        textField.attributedPlaceholder =
        NSAttributedString(string: nameRequest,
                           attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)])
        textField.borderStyle = .none
        textField.isUserInteractionEnabled = false
        //Создаём линию
        let line = CALayer()
        line.frame = CGRect(x: 0,
                            y: textField.frame.height + 5,
                            width: textField.frame.width,
                            height: 1)
        line.backgroundColor = UIColor.secondaryLabel.cgColor
        //Добавляем линию в сам TextField
        textField.layer.addSublayer(line)
        view.addSubview(textField)
    }
}
