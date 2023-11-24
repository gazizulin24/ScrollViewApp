//
//  Item.swift
//  ScrollViewApp
//
//  Created by Timur Gazizulin on 22.11.23.
//

import Foundation
import UIKit

struct Item{
    let title:String
    let subtitle:String
    let price:String
    let images:[UIImage]
    let colors:[UIColor]
    var isLiked:Bool = false
    let isCompatible:Bool
}
