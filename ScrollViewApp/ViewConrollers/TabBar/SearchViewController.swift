//
//  ViewController.swift
//  ScrollViewApp
//
//  Created by Timur Gazizulin on 22.11.23.
//

import UIKit

final class SearchViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // Scroll View
    private var myScrollView = UIScrollView()
    
    // "Search" Text Field
    private let searchTextField = UITextField()
    
    // "Recently Watched"
    private let recentlyWatchedView = UIView()
    private let recentlyWatchedLabel = UILabel()
    private let recentlyWatchedClearButton = UIButton(type:.system)
    private var recentlyWatchedCards:[UIView] = []
    private let recentlyWatchedData = [
                               Item(title: "IPhone 15 Pro", subtitle: "Смартфон Apple IPhone 15 Pro 128GB", price: "2499 BYN", images: [UIImage(named: "iphone1")!, UIImage(named: "iphone2")!, UIImage(named: "iphone3")!], colors: [UIColor.gray, UIColor.white, UIColor.darkGray], isCompatible: true, link: "https://www.apple.com/iphone-15-pro/"),
                               Item(title: "IPad Air M1", subtitle: "Планшет IPad Air 5TH GEN M1 Chip 256 GB", price: "2799 BYN", images: [UIImage(named: "ipad1")!, UIImage(named: "ipad2")!], colors: [UIColor.darkGray, UIColor.cyan, UIColor.magenta], isCompatible: true,link: "https://www.apple.com/ipad-air/"),
                               Item(title: "IPhone 13 Silicon Case", subtitle: "Чехол для IPhone 13 Silicon Case", price: "59 BYN", images: [UIImage(named: "chehol")!], colors: [UIColor.white], isCompatible: true,link: "https://www.apple.com/shop/product/MT203ZM/A/iphone-15-clear-case-with-magsafe?fnode=0662b6a20353c1ad25f5681436e5713f0cca30b9f068b5c01173ca822002b6f7e4367f4f0845a187510da4f25aff79dcef43a4001762fad028d47365d96e6f7b77ac08d0c2bd24fef55ca36d2a0a818f8a80f50ac136c37b643eb5b694af289b"),
                               Item(title: "MacBook Air M1", subtitle: "Ноутбук MacBook Air M1 8GB/256GB 2020", price: "2999 BYN", images: [UIImage(named: "mac")!], colors: [UIColor.gray, UIColor.white], isCompatible: true,link: "https://www.apple.com/macbook-air-m1/"),
                               Item(title: "AirPods Pro 2", subtitle: "Наушники AirPods Pro 2", price: "899 BYN", images: [UIImage(named: "pods1")!, UIImage(named: "pods2")!, UIImage(named: "pods3")!], colors: [UIColor.white], isCompatible: true,link: "https://www.apple.com/airpods-pro/"),
    ]
    
    // "Suggestions" Data
    private let otherVariantsData = ["Airpods", "AppleCare", "Beats", "Сравните модели IPhone"]
    
    override func viewWillAppear(_ animated:Bool){
        super.viewWillAppear(animated)
        setupNavigationBar()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchTextField()
        createRecentlyWatched()
        configScrollView()
        configOther()
        
    }
    
    // MARK: - Recently Watched Scroll View
    private func configScrollView(){
        // Settup
        let myScrollWidth = Double(self.view.bounds.size.width) * 0.33 * Double(recentlyWatchedData.count) + Double((recentlyWatchedData.count-1)*10)
        myScrollView.contentSize = CGSize(width: myScrollWidth, height: self.view.bounds.size.height * 0.2)
        myScrollView.showsVerticalScrollIndicator = false
        myScrollView.showsHorizontalScrollIndicator = false
        
        // Layout
        myScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(myScrollView)
        NSLayoutConstraint.activate([
            myScrollView.topAnchor.constraint(equalTo: recentlyWatchedView.bottomAnchor, constant: 15),
            myScrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            myScrollView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2),
            myScrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
        
        // Fill Scrol View
        for (i, dataItem) in recentlyWatchedData.enumerated(){
            createCard(dataItem, myScrollView, i)
        }
        
    }
    
    // MARK: - Item Card In Recently Watched Scroll View
    private func createCard(_ data:Any, _ view:UIScrollView, _ num:Int){
        // Item
        let item = recentlyWatchedData[num]
        
        // View Style
        let itemView = UIView()
        itemView.backgroundColor = UIColor(red: 0.34, green: 0.3, blue: 0.3, alpha: 0.30)
        itemView.layer.cornerRadius = 15
        itemView.tag = num
        
        // Tap Gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(itemSelected(_:)))
        itemView.addGestureRecognizer(tapGesture)
        
        // View Layout
        itemView.translatesAutoresizingMaskIntoConstraints = false
        if let lastSubview = view.subviews.last {
            // other items should have previous items leading anchors
            view.addSubview(itemView)
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: lastSubview.trailingAnchor, constant: 10),
                itemView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                itemView.heightAnchor.constraint(equalTo: view.heightAnchor),
                itemView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.33)
            ])
        } else{
            // first item should have scroll view leading anchor
            view.addSubview(itemView)
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                itemView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                itemView.heightAnchor.constraint(equalTo: view.heightAnchor),
                itemView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.33)
            ])
        }
        recentlyWatchedCards.append(itemView)
        
        // Image
        let itemImageView = UIImageView()
        itemImageView.image = item.images.first
        itemImageView.contentMode = .scaleAspectFit
        itemImageView.clipsToBounds = true
        
        
        // Image Layout
        itemView.addSubview(itemImageView)
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemImageView.centerXAnchor.constraint(equalTo: itemView.centerXAnchor),
            itemImageView.topAnchor.constraint(equalTo: itemView.topAnchor, constant: 15),
            itemImageView.widthAnchor.constraint(equalTo: itemView.widthAnchor, multiplier: 0.7),
            itemImageView.heightAnchor.constraint(equalTo: itemView.heightAnchor, multiplier: 0.5)
        ])
        
        // Label
        let itemLabel = UILabel()
        itemLabel.text = item.title
        itemLabel.textAlignment = .center
        itemLabel.textColor = .white
        itemLabel.font = .boldSystemFont(ofSize: 14)
        itemLabel.numberOfLines = 3
        itemLabel.textRect(forBounds: CGRect(x: 0, y: 0, width: 0, height: 0), limitedToNumberOfLines: 3)
        
        // Label Layout
        itemView.addSubview(itemLabel)
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemLabel.centerXAnchor.constraint(equalTo: itemView.centerXAnchor),
            itemLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 5),
            itemLabel.widthAnchor.constraint(equalTo: itemView.widthAnchor, multiplier: 0.8),
            itemLabel.heightAnchor.constraint(equalTo: itemView.heightAnchor, multiplier: 0.4)
        ])
        
    }
    
    // MARK: - Item In Scroll View Selected
    @objc func itemSelected(_ gesture:UITapGestureRecognizer){
        let vc = ItemViewController()
        if let tag = gesture.view?.tag{
            //print(recentlyWatchedData[tag])
            vc.item = recentlyWatchedData[tag]
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // MARK: - Recently watched (Label & Button)
    private func createRecentlyWatched(){
        // View Layout
        self.view.addSubview(recentlyWatchedView)
        recentlyWatchedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recentlyWatchedView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            recentlyWatchedView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 35),
            recentlyWatchedView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.93),
            recentlyWatchedView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.04)
        ])
        
        // Label Style
        recentlyWatchedLabel.textColor = .white
        recentlyWatchedLabel.textAlignment = .left
        recentlyWatchedLabel.text = "Недавно просмотренные"
        recentlyWatchedLabel.font = .boldSystemFont(ofSize: 22)
        
        // Label Layout
        recentlyWatchedView.addSubview(recentlyWatchedLabel)
        recentlyWatchedLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recentlyWatchedLabel.centerYAnchor.constraint(equalTo: recentlyWatchedView.centerYAnchor),
            recentlyWatchedLabel.leadingAnchor.constraint(equalTo: recentlyWatchedView.leadingAnchor),
            recentlyWatchedLabel.heightAnchor.constraint(equalTo: recentlyWatchedView.heightAnchor),
            recentlyWatchedLabel.widthAnchor.constraint(equalTo: recentlyWatchedView.widthAnchor, multiplier: 0.8)
        ])
        
        // Button Style
        recentlyWatchedClearButton.setTitle("Очистить", for: .normal)
        
        // Button Layout
        recentlyWatchedView.addSubview(recentlyWatchedClearButton)
        recentlyWatchedClearButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recentlyWatchedClearButton.centerYAnchor.constraint(equalTo: recentlyWatchedView.centerYAnchor),
            recentlyWatchedClearButton.leadingAnchor.constraint(equalTo: recentlyWatchedLabel.trailingAnchor),
            recentlyWatchedClearButton.heightAnchor.constraint(equalTo: recentlyWatchedView.heightAnchor),
            recentlyWatchedClearButton.widthAnchor.constraint(equalTo: recentlyWatchedView.widthAnchor, multiplier: 0.20)
        ])
        
    }
    
    // MARK: - "Search" Text Field
    private func setupSearchTextField(){
        // Placeholder
        let placeholderText = "Поиск по продуктам и магазинам"
        let attributes: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor.lightGray ]
        let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        searchTextField.attributedPlaceholder = attributedPlaceholder
        
        // Left view
        let leftView = UIView(frame: CGRect(x: 0,y: 0,width: 30, height: 20))
        let leftViewImage = UIImageView(image: UIImage(systemName: "magnifyingglass")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal))
        leftViewImage.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
                              leftViewImage.contentMode = .center
        leftView.addSubview(leftViewImage)
        searchTextField.leftView = leftView
        searchTextField.leftViewMode = .always
        
        // Style
        searchTextField.backgroundColor = UIColor(red: 0.34, green: 0.3, blue: 0.3, alpha: 0.30)
        searchTextField.layer.cornerRadius = 10
        searchTextField.textColor = .white
        
        // Delegate
        searchTextField.delegate = self
        
        // Add to superview
        self.view.addSubview(searchTextField)
        
        // Layout
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            searchTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            searchTextField.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.93),
            searchTextField.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.045)
        ])
        
    }

    //MARK: - Navigation Bar
    private func setupNavigationBar(){
        // Title
        self.title = "Поиск"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        // Background
        self.navigationController?.navigationBar.backgroundColor = .black
        
    }
    
    // MARK: - Things under Scroll View
    private func configOther(){
        // Label Style
        let otherLabel = UILabel()
        otherLabel.textColor = .white
        otherLabel.textAlignment = .left
        otherLabel.text = "Варианты запросов"
        otherLabel.font = .boldSystemFont(ofSize: 22)
        
        // Label Layout
        self.view.addSubview(otherLabel)
        otherLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            otherLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            otherLabel.topAnchor.constraint(equalTo: myScrollView.bottomAnchor, constant: 30),
            otherLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05),
            otherLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.93)
        ])
        
        
        // Create "Suggestions"
        for (numberPosition, nameRequest) in otherVariantsData.enumerated(){
            createSuggestion(nameRequest, otherLabel, numberPosition)
        }
        
    }
    
    // MARK: - Create Suggestion
    private func createSuggestion(_ nameRequest: String, _ otherLabel: UILabel, _ numberPosition: Int) {
        // Text field
        let textField = UITextField()
        textField.textColor = .white
        textField.text = nameRequest
        textField.attributedPlaceholder =
        NSAttributedString(string: nameRequest,
                           attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)])
        textField.borderStyle = .none
        textField.isUserInteractionEnabled = true
        view.addSubview(textField)
        
        // Text field image
        let requestSearchImageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        let requestsSearchView = UIView(frame: CGRect(x: 0,y: 0,width: 40,height: 20))
        textField.leftViewMode = .always
        requestSearchImageView.frame = CGRect(x: 10, y: 0, width: 20, height: 20)
        requestSearchImageView.tintColor = .lightGray
        requestSearchImageView.contentMode = .center
        requestsSearchView.addSubview(requestSearchImageView)
        textField.leftView = requestSearchImageView
        
        // Text field tap gesture
        let tapToTextField = UITapGestureRecognizer(target: self, action: #selector(tapToTextField(_:)))
        textField.addGestureRecognizer(tapToTextField)
        
        // Text Field Layout
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: otherLabel.bottomAnchor, constant: CGFloat((numberPosition * 45))),
            textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textField.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            textField.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        // Text Field Underline
        let line = UIView()
        line.backgroundColor = .darkGray
        self.view.addSubview(line)
        
        // Underline Layout
        line.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            line.centerXAnchor.constraint(equalTo: textField.centerXAnchor),
            line.topAnchor.constraint(equalTo: textField.bottomAnchor),
            line.widthAnchor.constraint(equalTo: textField.widthAnchor),
            line.heightAnchor.constraint(equalToConstant: 1)
        ])
        
    }
    
    // MARK: - Tap To "Suggestions" Text Field
    @objc func tapToTextField(_ sender:UITapGestureRecognizer){
        if let view = sender.view as? UITextField{
            searchTextField.becomeFirstResponder()
            searchTextField.text = view.text
        }
        
    }
    
}

// MARK: - Text Field Delegate
extension SearchViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
}
