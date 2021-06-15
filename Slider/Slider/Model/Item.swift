//
//  Item.swift
//  Slider
//
//  Created by Марк Шнейдерман on 14.06.2021.
//

import Foundation

protocol ItemProtocol {
    var firstValue : String {get set}
    var secondValue : String {get set}
}

struct Item : ItemProtocol {
    var firstValue: String
    var secondValue: String
}
