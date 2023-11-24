//
//  ItemViewController.swift
//  ScrollViewApp
//
//  Created by Timur Gazizulin on 22.11.23.
//

import UIKit

final class ItemViewController: UIViewController, UINavigationControllerDelegate {
    // Item
    var item:Item = Item(title: "Item", subtitle: "", price: "", images: [], colors: [], isCompatible: true, link: "")
    
    // Title
    private let titleLabel = UILabel()
    
    // Price
    private let priceLabel = UILabel()
    
    // Description
    private let descriptionLabel = UILabel()
    
    // "Compatible"
    private let compatibleLabel = UILabel()
    private let compatibleImage = UIImageView()
    
    // Delivery
    private let deliveryTodayLabel = UILabel()
    private let deliveryDateLabel = UILabel()
    private let deliveryLocationLabel = UILabel()
    private let deliveryImageView = UIImageView()
    
    // Scroll View
    private let imagesScroll = UIScrollView()
    
    // Like/Unlike Images
    private let unlikedItemImage = UIImage(systemName: "heart")
    private let likedItemImage = UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
    
    // Color buttons
    private let colorButtonsView = UIView()
    private var colorButtons:[UIButton] = []
    
    // Buy
    private let buyButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configNavBar()
        createTitleLabel()
        createPriceLabel()
        createImagesScroll()
        createDescriptionLabel()
        createColorsButtons()
        createCompatibleWith()
        createBuyButton()
        createDeliveryInfo()
    }
    
    // MARK: - Buy Button
    private func createBuyButton(){
        // Style
        buyButton.configuration = .filled()
        buyButton.setTitle("Добавить в корзину", for: .normal)
        
        self.view.addSubview(buyButton)
        
        // Layout
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buyButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            buyButton.topAnchor.constraint(equalTo: compatibleLabel.bottomAnchor, constant: 20),
            buyButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            buyButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05)
        ])
    }
    
    // MARK: - "Compatible with" info
    private func createCompatibleWith(){
        // Label Style
        let colorText = "MacBook Pro - Timur"
        var whiteWords = "Совместимо с MacBook Pro - Timur"
        
        if item.isCompatible{
            whiteWords = "Совместимо с MacBook Pro - Timur"
        } else{
            whiteWords = "Не совместимо с MacBook Pro - Timur"
        }
        
        // Label attributed text
        let range = (whiteWords as NSString).range(of: colorText)
        let atributesString = NSMutableAttributedString(string: whiteWords)
        atributesString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemBlue, range: range)
        compatibleLabel.textColor = .gray
        compatibleLabel.attributedText = atributesString
        compatibleLabel.font = UIFont.systemFont(ofSize: 13)
        compatibleLabel.textAlignment = .left
        compatibleLabel.sizeToFit()
        
        self.view.addSubview(compatibleLabel)
        
        // Label Layout
        compatibleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            compatibleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            compatibleLabel.topAnchor.constraint(equalTo: colorButtonsView.bottomAnchor, constant: 15),
            compatibleLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.57),
            compatibleLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05)
        ])
        
        // Image Style
        if item.isCompatible{
            compatibleImage.image = UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.green, renderingMode: .alwaysOriginal)
        } else{
            compatibleImage.image = UIImage(systemName: "xmark.circle.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        }
        
        self.view.addSubview(compatibleImage)
        
        // Image Layout
        compatibleImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            compatibleImage.centerYAnchor.constraint(equalTo: compatibleLabel.centerYAnchor),
            compatibleImage.leadingAnchor.constraint(equalTo: compatibleLabel.leadingAnchor, constant: self.view.bounds.width * 0.05 * -2),
            compatibleImage.widthAnchor.constraint(equalTo: compatibleLabel.heightAnchor, multiplier: 0.5),
            compatibleImage.heightAnchor.constraint(equalTo: compatibleLabel.heightAnchor, multiplier: 0.5)
        ])
    }
    
    // MARK: - Navigation Bar
    private func configNavBar(){
        // NavBar Style
        if let navBar = self.navigationController?.navigationBar{
            navBar.prefersLargeTitles = false
        }
        
        // Right Bar Items
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonTapped(_:)))
        
        let likeButton = UIBarButtonItem(image: unlikedItemImage, style: .plain, target: self, action: #selector(likeButtonTapped(_:)))
        
        self.navigationItem.rightBarButtonItems = [likeButton, shareButton]
    }
    
    // MARK: - Did Tap Share Button
    @objc func shareButtonTapped(_ sender:UIBarButtonItem){
        let ac = UIActivityViewController(activityItems: [item.title], applicationActivities: nil)
        present(ac,animated: true)
    }
    
    
    // MARK: - Did Tap Like Button
    @objc func likeButtonTapped(_ sender: UIBarButtonItem){
        item.isLiked.toggle()
        if item.isLiked{
            sender.image = likedItemImage
        } else{
            sender.image = unlikedItemImage
        }
    }
    
    // MARK: - Colors Buttons
    private func createColorsButtons(){
        // Colors Buttons View Layout
        colorButtonsView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(colorButtonsView)
        NSLayoutConstraint.activate([
            colorButtonsView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            colorButtonsView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            colorButtonsView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.055),
            colorButtonsView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.12 * CGFloat( item.colors.count))
        ])
        
        // Create Colors Button
        for (num, buttonColor) in item.colors.enumerated(){
            createColorButton(colorButtonsView, buttonColor, num)
        }
        
        // Select First color
        selectColor(colorButtons.first!)
    }
    
    // MARK: - Color Button
    private func createColorButton(_ view:UIView, _ color:UIColor, _ num:Int){
        // Constant button size
        let circleSize = CGFloat(40)
        
        // Button Style
        let circleButton = UIButton()
        circleButton.backgroundColor = color
        circleButton.layer.borderColor = UIColor.black.cgColor
        circleButton.layer.borderWidth = 2
        circleButton.layer.cornerRadius = circleSize/2
        
        // Add Color Button To SuperView (Colors Buttons View)
        view.addSubview(circleButton)
        
        // Button Target
        circleButton.addTarget(self, action: #selector(selectColor(_:)), for: .touchUpInside)
        
        // Button Layout
        circleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            circleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(10 + 50*num)),
            circleButton.widthAnchor.constraint(equalToConstant: circleSize),
            circleButton.heightAnchor.constraint(equalToConstant: circleSize)
        ])
        
        // Add Button to buttons array to hundle their in future
        colorButtons.append(circleButton)
    }
    
    // MARK: - Select Item Color
    @objc func selectColor(_ sender: UIButton){
        // Deselect other colors
        for button in colorButtons{
            button.layer.borderColor = UIColor.black.cgColor
        }
        // Select color
        sender.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    // MARK: - Item Description Label
    private func createDescriptionLabel(){
        // Style
        descriptionLabel.text = item.subtitle
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .gray
        descriptionLabel.sizeToFit()
        
        self.view.addSubview(descriptionLabel)
        
        // Layout
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: imagesScroll.bottomAnchor, constant: 10),
            descriptionLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            descriptionLabel.heightAnchor.constraint(equalTo:self.view.heightAnchor, multiplier: 0.03)
        ])
    }
    
    // MARK: - Scroll View
    private func createImagesScroll(){
        // Style
        imagesScroll.isPagingEnabled = true
        imagesScroll.contentSize = CGSize(width: self.view.bounds.width * CGFloat(item.images.count), height: self.view.bounds.height * 0.3)
        imagesScroll.showsVerticalScrollIndicator = false
        imagesScroll.showsHorizontalScrollIndicator = true
        imagesScroll.indicatorStyle = .white
        
        self.view.addSubview(imagesScroll)
        
        // Gesture To Open WebView
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openWebView(_:)))
        imagesScroll.addGestureRecognizer(gesture)
        
        // Add Images
        fillImages(imagesScroll, item.images)
        
        // Layout
        imagesScroll.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imagesScroll.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imagesScroll.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            imagesScroll.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            imagesScroll.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3)
        ])
    }
    
    // MARK: - Adding Images To Scroll View
    private func fillImages(_ scroll:UIScrollView, _ images:[UIImage]){
        for (num, image) in images.enumerated(){
            
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            
            imageView.frame = CGRect(x: self.view.bounds.width * CGFloat(num), y: 0, width: self.view.bounds.width, height: self.view.bounds.height * 0.3)
            
            
            scroll.addSubview(imageView)
        }
        
    }
    
    //MARK: - Open WebView
    @objc func openWebView(_ sender: UITapGestureRecognizer){
        let vc = ItemWebViewController()
        vc.link = item.link
        present(vc, animated: true)
    }
    
    // MARK: - Item Price Label
    private func createPriceLabel(){
        // Style
        priceLabel.text = item.price
        priceLabel.font = UIFont.systemFont(ofSize: 12)
        priceLabel.textAlignment = .center
        priceLabel.textColor = .gray
        
        self.view.addSubview(priceLabel)
        
        // Layout
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            priceLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            priceLabel.heightAnchor.constraint(equalTo:self.view.heightAnchor, multiplier: 0.02)
        ])
    }
    
    // MARK: - Item Title Label
    private func createTitleLabel() {
        // Style
        titleLabel.text = item.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        
        self.view.addSubview(titleLabel)
        
        // Layout
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            titleLabel.heightAnchor.constraint(equalTo:self.view.heightAnchor, multiplier: 0.03)
        ])
    }
    
    // MARK: - Delivery Info
    private func createDeliveryInfo(){
        // 1st Label
        deliveryTodayLabel.text = "Заказ сегодня в течение дня, доставка:"
        deliveryTodayLabel.textAlignment = .left
        deliveryTodayLabel.textColor = .white
        deliveryTodayLabel.font = .boldSystemFont(ofSize: 11)
        
        self.view.addSubview(deliveryTodayLabel)
        
        // 1st Label Layout
        deliveryTodayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deliveryTodayLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            deliveryTodayLabel.topAnchor.constraint(equalTo: buyButton.bottomAnchor, constant: 30),
            deliveryTodayLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75),
            deliveryTodayLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.015)
        ])
        
        // 2nd Label
        deliveryDateLabel.text = "Пн 27 Ноября - Бесплатно"
        deliveryDateLabel.textAlignment = .left
        deliveryDateLabel.textColor = .gray
        deliveryDateLabel.font = .systemFont(ofSize: 11)
        
        self.view.addSubview(deliveryDateLabel)
        
        // 2nd Label Layout
        deliveryDateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deliveryDateLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            deliveryDateLabel.topAnchor.constraint(equalTo: deliveryTodayLabel.bottomAnchor, constant: 2),
            deliveryDateLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75),
            deliveryDateLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.015)
        ])
        
        // 3rd Label
        deliveryLocationLabel.text = "Варианты доставки для местоположения: 115533"
        deliveryLocationLabel.textAlignment = .left
        deliveryLocationLabel.textColor = .systemBlue
        deliveryLocationLabel.font = .systemFont(ofSize: 11)
        
        self.view.addSubview(deliveryLocationLabel)
        
        // 3rd Label Layout
        deliveryLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deliveryLocationLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            deliveryLocationLabel.topAnchor.constraint(equalTo: deliveryDateLabel.bottomAnchor, constant: 2),
            deliveryLocationLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75),
            deliveryLocationLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.015)
        ])
        
        // Image
        deliveryImageView.image = UIImage(systemName: "cube.box")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        
        self.view.addSubview(deliveryImageView)
        
        // Image Layout
        deliveryImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deliveryImageView.centerYAnchor.constraint(equalTo: deliveryTodayLabel.centerYAnchor),
            deliveryImageView.leadingAnchor.constraint(equalTo: deliveryTodayLabel.leadingAnchor, constant: self.view.bounds.width * 0.05 * -2),
            deliveryImageView.widthAnchor.constraint(equalTo: compatibleLabel.heightAnchor, multiplier: 0.5),
            deliveryImageView.heightAnchor.constraint(equalTo: compatibleLabel.heightAnchor, multiplier: 0.5)
        ])
        
    }

    // MARK: - Костыльная функция изменения цвета навбара выглядит не оч но можно добавить во viewDidAppear
    private func navBarColor(){
        if let navBar = self.navigationController?.navigationBar{
            navBar.backgroundColor = UIColor(red: 0.34, green: 0.3, blue: 0.3, alpha: 0.3)
            let statusBarView = UIView(frame: view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBarView.backgroundColor = UIColor(red: 0.34, green: 0.3, blue: 0.3, alpha: 0.3)
            view.addSubview(statusBarView)
        }
    }
}
