//
//  CartViewController.swift
//  ScrollViewApp
//
//  Created by Timur Gazizulin on 23.11.23.
//

import UIKit

final class CartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        createTitleLabel()
    }
    

    private func createTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.text = "Страница Корзина пока недоступна "
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.sizeToFit()
        titleLabel.center = self.view.center
        self.view.addSubview(titleLabel)
    }

}
