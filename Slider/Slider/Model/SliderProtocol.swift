//
//  SliderProtocol.swift
//  Slider
//
//  Created by Марк Шнейдерман on 14.06.2021.
//

import Foundation

protocol SliderProtocol: class {
    /// CardSliderItem for the card at given index, counting from the top.
    func item(for index: Int) -> Item
    
    /// Total number of cards.
    func numberOfItems() -> Int
}
