//
//  InfoProduct.swift
//  Lesson 16 and 17 - UIScrollView & UIImage & UIImageView - Products
//
//  Created by Валентин Ремизов on 07.03.2023.
//

import UIKit

class InfoProduct: UIViewController {
    var nameProductLabel = UILabel()
    var priceProductLabel = UILabel()
    private let imageScrollView = UIScrollView()
    var nameProductDuplicateLabel = UILabel()
    private let circleFillImage = UIImage(systemName: "circle.fill")
    private let circleFillDarkGrayImageView = UIImageView()
    private let circleFillLightGrayImageView = UIImageView()
    private let checkMarkImageView = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
    private let doubleColorLabel = UILabel()
    private let addToCartButton = UIButton()
    private let boxImageView = UIImageView(image: UIImage(systemName: "cube.box"))
    private let deliveryOneLabel = UILabel(frame: CGRect(x: 50,
                                                         y: 700,
                                                         width: 300,
                                                         height: 12))
    private let deliveryTwoLabel = UILabel(frame: CGRect(x: 50,
                                                         y: 715,
                                                         width: 300,
                                                         height: 12))
    private let deliveryThreeLabel = UILabel(frame: CGRect(x: 50,
                                                           y: 730,
                                                           width: 300,
                                                           height: 12))
    private let picturesOneArray = [UIImageView(image: UIImage(named: "case")),
                                    UIImageView(image: UIImage(named: "case12")),
                                    UIImageView(image: UIImage(named: "case13")),
                                    UIImageView(image: UIImage(named: "case14"))]
    private let picturesTwoArray = [UIImageView(image: UIImage(named: "strap")),
                                    UIImageView(image: UIImage(named: "strap2")),
                                    UIImageView(image: UIImage(named: "strap3")),
                                    UIImageView(image: UIImage(named: "strap4"))]
    private let picturesThreeArray = [UIImageView(image: UIImage(named: "case2")),
                                      UIImageView(image: UIImage(named: "case22")),
                                      UIImageView(image: UIImage(named: "case23")),
                                      UIImageView(image: UIImage(named: "case24"))]
    private let picturesFourArray = [UIImageView(image: UIImage(named: "iphone")),
                                     UIImageView(image: UIImage(named: "iphone2")),
                                     UIImageView(image: UIImage(named: "iphone3")),
                                     UIImageView(image: UIImage(named: "iphone4"))]
    private var isLiked = false

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Почему-то во ViewDidLoad не работает это, поэтому делаю здесь.
        let navBar = self.navigationController?.navigationBar
        //Возвращаем обратно обычный бар (без увеличенного заголовка)
        navBar?.prefersLargeTitles = false
        //Меняем фон у navigationBar
        navBar?.backgroundColor = .tertiaryLabel
        //Меняем фон у statusBar
        let statusBarView = UIView(frame: view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
        statusBarView.backgroundColor = .tertiaryLabel
        view.addSubview(statusBarView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //Создаём 2 элемента бара справа
        navigationItem.setRightBarButtonItems([UIBarButtonItem(image: UIImage(systemName: "heart"),
                                                               style: .done,
                                                               target: self,
                                                               action: #selector(likePressed)),
                                               UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"),
                                                               style: .done,
                                                               target: self,
                                                               action: #selector(sharePressed))],
                                              animated: true)
        createNameProduct()
        createPriceProduct()
        createNameProductDuplicate()
        createCircle(color: circleFillDarkGrayImageView)
        createCircle(color: circleFillLightGrayImageView)
        createCheckMark()
        createDoubleColorLabel()
        createAddToCartButton()
        createBoxImageView()
        createDeliveryOne()
        createDeliveryTwo()
        createDeliveryThree()

        [nameProductLabel, priceProductLabel,imageScrollView, nameProductLabel,
         nameProductDuplicateLabel, circleFillDarkGrayImageView,
         circleFillLightGrayImageView, checkMarkImageView, doubleColorLabel,
         addToCartButton, boxImageView, deliveryOneLabel, deliveryTwoLabel,
         deliveryThreeLabel].forEach{view.addSubview($0)}
    }

    fileprivate func createNameProduct() {
        nameProductLabel.frame = CGRect(x: 10,
                                        y: 100,
                                        width: view.frame.width - 20,
                                        height: 34)
        nameProductLabel.textColor = .white
        nameProductLabel.font = .boldSystemFont(ofSize: 16)
        nameProductLabel.textAlignment = .center
        nameProductLabel.numberOfLines = 1
    }

    fileprivate func createPriceProduct() {
        priceProductLabel.frame = CGRect(x: 10,
                                         y: 140,
                                         width: view.frame.width - 20,
                                         height: 20)
        priceProductLabel.textColor = .lightGray
        priceProductLabel.font = .systemFont(ofSize: 14)
        priceProductLabel.textAlignment = .center
        priceProductLabel.numberOfLines = 1
    }

//MARK: - Создание ScrollView
    func createImageScrollView(tag: Int) {
        imageScrollView.frame = CGRect(x: 0,
                                       y: 180,
                                       width: view.frame.width,
                                       height: 250)
        imageScrollView.contentSize = CGSize(width: view.frame.width * 4,
                                             height: imageScrollView.frame.height)
        imageScrollView.indicatorStyle = .black
//Листание картинок как фотографии
        imageScrollView.isPagingEnabled = true
        if tag == 0 {
            picturesOneArray[0].frame = CGRect(x: 0,
                                               y: 0,
                                               width: imageScrollView.bounds.width,
                                               height: imageScrollView.bounds.height)
            picturesOneArray[0].contentMode = .scaleAspectFit
            imageScrollView.addSubview(picturesOneArray[0])
            picturesOneArray[1].frame = CGRect(x: imageScrollView.bounds.width,
                                               y: 0,
                                               width: imageScrollView.bounds.width,
                                               height: imageScrollView.bounds.height)
            picturesOneArray[1].contentMode = .scaleAspectFit
            imageScrollView.addSubview(picturesOneArray[1])
            picturesOneArray[2].frame = CGRect(x: imageScrollView.bounds.width * 2,
                                               y: 0,
                                               width: imageScrollView.bounds.width,
                                               height: imageScrollView.bounds.height)
            picturesOneArray[2].contentMode = .scaleAspectFit
            imageScrollView.addSubview(picturesOneArray[2])
            picturesOneArray[3].frame = CGRect(x: imageScrollView.bounds.width * 3,
                                               y: 0,
                                               width: imageScrollView.bounds.width,
                                               height: imageScrollView.bounds.height)
            picturesOneArray[3].contentMode = .scaleAspectFit
            imageScrollView.addSubview(picturesOneArray[3])
        } else if tag == 1 {
            picturesTwoArray[0].frame = CGRect(x: 0,
                                               y: 0,
                                               width: imageScrollView.bounds.width,
                                               height: imageScrollView.bounds.height)
            picturesTwoArray[0].contentMode = .scaleAspectFit
            imageScrollView.addSubview(picturesTwoArray[0])
            picturesTwoArray[1].frame = CGRect(x: imageScrollView.bounds.width,
                                               y: 0,
                                               width: imageScrollView.bounds.width,
                                               height: imageScrollView.bounds.height)
            picturesTwoArray[1].contentMode = .scaleAspectFit
            imageScrollView.addSubview(picturesTwoArray[1])
            picturesTwoArray[2].frame = CGRect(x: imageScrollView.bounds.width * 2,
                                               y: 0,
                                               width: imageScrollView.bounds.width,
                                               height: imageScrollView.bounds.height)
            picturesTwoArray[2].contentMode = .scaleAspectFit
            imageScrollView.addSubview(picturesTwoArray[2])
            picturesTwoArray[3].frame = CGRect(x: imageScrollView.bounds.width * 3,
                                               y: 0,
                                               width: imageScrollView.bounds.width,
                                               height: imageScrollView.bounds.height)
            picturesTwoArray[3].contentMode = .scaleAspectFit
            imageScrollView.addSubview(picturesTwoArray[3])
        } else if tag == 2 {
            picturesThreeArray[0].frame = CGRect(x: 0,
                                                 y: 0,
                                                 width: imageScrollView.bounds.width,
                                                 height: imageScrollView.bounds.height)
            picturesThreeArray[0].contentMode = .scaleAspectFit
            imageScrollView.addSubview(picturesThreeArray[0])
            picturesThreeArray[1].frame = CGRect(x: imageScrollView.bounds.width,
                                                 y: 0,
                                                 width: imageScrollView.bounds.width,
                                                 height: imageScrollView.bounds.height)
            picturesThreeArray[1].contentMode = .scaleAspectFit
            imageScrollView.addSubview(picturesThreeArray[1])
            picturesThreeArray[2].frame = CGRect(x: imageScrollView.bounds.width * 2,
                                                 y: 0,
                                                 width: imageScrollView.bounds.width,
                                                 height: imageScrollView.bounds.height)
            picturesThreeArray[2].contentMode = .scaleAspectFit
            imageScrollView.addSubview(picturesThreeArray[2])
            picturesThreeArray[3].frame = CGRect(x: imageScrollView.bounds.width * 3,
                                                 y: 0,
                                                 width: imageScrollView.bounds.width,
                                                 height: imageScrollView.bounds.height)
            picturesThreeArray[3].contentMode = .scaleAspectFit
            imageScrollView.addSubview(picturesThreeArray[3])
        } else {
            picturesFourArray[0].frame = CGRect(x: 0,
                                                y: 0,
                                                width: imageScrollView.bounds.width,
                                                height: imageScrollView.bounds.height)
            picturesFourArray[0].contentMode = .scaleAspectFit
            imageScrollView.addSubview(picturesFourArray[0])
            picturesFourArray[1].frame = CGRect(x: imageScrollView.bounds.width,
                                                y: 0,
                                                width: imageScrollView.bounds.width,
                                                height: imageScrollView.bounds.height)
            picturesFourArray[1].contentMode = .scaleAspectFit
            imageScrollView.addSubview(picturesFourArray[1])
            picturesFourArray[2].frame = CGRect(x: imageScrollView.bounds.width * 2,
                                                y: 0,
                                                width: imageScrollView.bounds.width,
                                                height: imageScrollView.bounds.height)
            picturesFourArray[2].contentMode = .scaleAspectFit
            imageScrollView.addSubview(picturesFourArray[2])
            picturesFourArray[3].frame = CGRect(x: imageScrollView.bounds.width * 3,
                                                y: 0,
                                                width: imageScrollView.bounds.width,
                                                height: imageScrollView.bounds.height)
            picturesFourArray[3].contentMode = .scaleAspectFit
            imageScrollView.addSubview(picturesFourArray[3])
        }
        //Делаем похожий indicatorStyle за счёт добавления на задний фон белой вью в качестве фона, а индикатор черного цвета.
        let lineView = UIView(frame: CGRect(x: 0,
                                            y: imageScrollView.bounds.height - 6,
                                            width: imageScrollView.contentSize.width,
                                            height: 3))
        lineView.backgroundColor = .white
        lineView.layer.cornerRadius = lineView.frame.height / 2
        imageScrollView.addSubview(lineView)
    }

    fileprivate func createNameProductDuplicate() {
        nameProductDuplicateLabel.frame = CGRect(x: 10,
                                                 y: 430,
                                                 width: view.frame.width - 20,
                                                 height: 20)
        nameProductDuplicateLabel.textColor = .lightGray
        nameProductDuplicateLabel.textAlignment = .center
        nameProductDuplicateLabel.font = .systemFont(ofSize:12)
        nameProductDuplicateLabel.numberOfLines = 1
    }

//MARK: - Создание цветных кругляшков для выбора цвета продукта
    fileprivate func createCircle(color: UIImageView) {

        if color == circleFillDarkGrayImageView {
            color.tintColor = .darkGray
            color.frame = CGRect(x: Int(view.frame.width) / 2 + 5,
                                               y: 480,
                                               width: 40,
                                               height: 40)
            color.layer.borderColor = UIColor.systemBlue.cgColor
        } else {
            color.tintColor = .lightGray
            color.frame = CGRect(x: Int(view.frame.width) / 2 - 40 - 5,
                                 y: 480,
                                 width: 40,
                                 height: 40)
            color.layer.borderColor = UIColor.black.cgColor
        }

        color.image = circleFillImage
        color.layer.cornerRadius = color.frame.height / 2
        color.layer.borderWidth = 1

        let doubleLine = CALayer()
        doubleLine.frame = color.bounds
        doubleLine.cornerRadius = doubleLine.frame.height / 2
        doubleLine.borderWidth = 4
        doubleLine.borderColor = UIColor.black.cgColor
        color.layer.insertSublayer(doubleLine, above: color.layer)

        if color == circleFillDarkGrayImageView {
            let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                           action: #selector(changeSelectedDarkGray))
            color.addGestureRecognizer(gestureRecognizer)
        } else {
            let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                           action: #selector(changeSelectedLightGray))
            color.addGestureRecognizer(gestureRecognizer)
        }
        color.isUserInteractionEnabled = true
    }

    @objc private func changeSelectedDarkGray() {
        changeSelected(selected: circleFillDarkGrayImageView, noSelected: circleFillLightGrayImageView)
    }

    @objc private func changeSelectedLightGray() {
        changeSelected(selected: circleFillLightGrayImageView, noSelected: circleFillDarkGrayImageView)
    }

    private func changeSelected(selected: UIImageView, noSelected: UIImageView) {
        selected.layer.borderColor = UIColor.systemBlue.cgColor
        noSelected.layer.borderColor = UIColor.black.cgColor
    }

    fileprivate func createCheckMark() {
        checkMarkImageView.frame = CGRect(x: 50, y: 570, width: 20, height: 20)
        checkMarkImageView.contentMode = .scaleAspectFill
        checkMarkImageView.tintColor = .systemGreen
    }

    fileprivate func createDoubleColorLabel() {
        let colorText = "MacBook Pro - Валентин"
        let whiteWords = "Совместимо с MacBook Pro - Валентин"
        let range = (whiteWords as NSString).range(of: colorText)
        let atributesString = NSMutableAttributedString(string: whiteWords)
        atributesString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemBlue, range: range)
        doubleColorLabel.textColor = .lightGray
        doubleColorLabel.attributedText = atributesString
        doubleColorLabel.frame = CGRect(x: 0,
                                        y: 570,
                                        width: view.frame.width,
                                        height: 20)
        doubleColorLabel.textAlignment = .center
        doubleColorLabel.font = .systemFont(ofSize: 12)
    }

    fileprivate func createAddToCartButton() {
        addToCartButton.frame = CGRect(x: 10,
                                       y: 620,
                                       width: view.bounds.width - 20,
                                       height: 40)
        addToCartButton.backgroundColor = .systemBlue
        addToCartButton.layer.cornerRadius = addToCartButton.frame.height / 4
        addToCartButton.setTitle("Add to cart", for: .normal)
        addToCartButton.setTitleColor(.white, for: .normal)
        addToCartButton.titleLabel?.textAlignment = .center
        addToCartButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
    }

    fileprivate func createBoxImageView() {
        boxImageView.frame = CGRect(x: 10, y: 700, width: 18, height: 18)
        boxImageView.tintColor = .lightGray
    }

    fileprivate func createDeliveryOne() {
        deliveryOneLabel.text = "Order today during of day, delivery:"
        deliveryOneLabel.textColor = .white
        deliveryOneLabel.textAlignment = .left
        deliveryOneLabel.font = .boldSystemFont(ofSize: 12)
    }

    fileprivate func createDeliveryTwo() {
        deliveryTwoLabel.text = "Thu 25 Feb - Free"
        deliveryTwoLabel.textColor = .lightGray
        deliveryTwoLabel.textAlignment = .left
        deliveryTwoLabel.font = .systemFont(ofSize: 12)
    }

    fileprivate func createDeliveryThree() {
        deliveryThreeLabel.text = "Delivery options for location: 115533"
        deliveryThreeLabel.textColor = .systemBlue
        deliveryThreeLabel.textAlignment = .left
        deliveryThreeLabel.font = .systemFont(ofSize: 12)
    }

    @objc private func sharePressed() {
        guard let productName = nameProductLabel.text else { return }
        let shareButton = UIActivityViewController(activityItems: [productName], applicationActivities: nil)
        self.present(shareButton, animated: true)
    }

    @objc private func likePressed() {
        if isLiked {
            navigationItem.rightBarButtonItems?[0].image = UIImage(systemName: "heart")
            navigationItem.rightBarButtonItems?[0].tintColor = UIColor.systemBlue
            isLiked = false
        } else {
            navigationItem.rightBarButtonItems?[0].image = UIImage(systemName: "heart.fill")
            navigationItem.rightBarButtonItems?[0].tintColor = UIColor.red
            isLiked = true
        }
    }
}
