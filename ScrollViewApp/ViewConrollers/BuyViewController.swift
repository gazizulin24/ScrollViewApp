//
//  OtherViewController.swift
//  ScrollViewApp
//
//  Created by Timur Gazizulin on 22.11.23.
//

import UIKit

class BuyViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTitleLabel()
    }
    

    func createTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.text = "Страница Купить пока недоступна "
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.sizeToFit()
        titleLabel.center = self.view.center
        self.view.addSubview(titleLabel)
    }
    

}
