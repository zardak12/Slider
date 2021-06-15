//
//  ViewController.swift
//  Slider
//
//  Created by Марк Шнейдерман on 14.06.2021.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDelegate {
    
    let words = [Item(firstValue: "Go", secondValue: "Идти"),Item(firstValue: "Animal", secondValue: "Животное"),Item(firstValue: "Pet", secondValue: "Домашний питомец"),Item(firstValue: "Hello", secondValue: "Привет"),Item(firstValue: "Goodbuy", secondValue: "Пока"),Item(firstValue: "Ball", secondValue: "Мяч"),]
    
    lazy var collectionView : UICollectionView = {
        let layout = SliderCollectionViewLayout()
        layout.delegate = self
        let collection =  UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(SliderCollectionViewCell.self, forCellWithReuseIdentifier: SliderCollectionViewCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.layoutIfNeeded()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        view.addSubview(collectionView)
        setConstraint()
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delaysContentTouches = false
    }
    
    func setConstraint() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -100)
        ])
    }


}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  words.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderCollectionViewCell.identifier, for: indexPath) as! SliderCollectionViewCell
        let item = words[indexPath.item]
        cell.configure(with: item.firstValue)
        //cell.imageView.image = UIImage(named: "марк")
        return cell
    }
    
 }

extension ViewController: CardsLayoutDelegate {
    func transition(between currentIndex: Int, and nextIndex: Int, progress: CGFloat) {
        let currentItem = words[currentIndex]
        let nextItem = words[nextIndex]
    }
}
