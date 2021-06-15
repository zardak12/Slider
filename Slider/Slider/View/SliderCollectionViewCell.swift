//
//  SliderCollectionViewCell.swift
//  Slider
//
//  Created by Марк Шнейдерман on 14.06.2021.
//

import UIKit

class SliderCollectionViewCell: UICollectionViewCell , ParallaxCardCell{
    
    static let identifier = "identifier"
    
    var cornerRadius: CGFloat = 10 { didSet { update() }}
    var shadowOpacity: CGFloat = 0.3 { didSet { update() }}
    var shadowColor: UIColor = .black { didSet { update() }}
    var shadowRadius: CGFloat = 20 { didSet { update() }}
    var shadowOffset: CGSize = CGSize(width: 0, height: 20) { didSet { update() }}
    var select = false
    
    /// Maximum image zoom during scrolling
    open var maxZoom: CGFloat {
        return 1.3
    }
    
    private var zoom: CGFloat = 0
    private var shadeOpacity: CGFloat = 0
    
    var imageView = UIImageView()
    
    lazy var label :  UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        label.sizeToFit()
        return label
    }()
    
    var shadeView = UIView()
    var highlightView = UIView()
    
    private var latestBounds: CGRect?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(label)
        getConstraint()
        shadeView.backgroundColor = .clear
        contentView.addSubview(shadeView)
        highlightView.backgroundColor = .clear
        highlightView.alpha = 0
        contentView.addSubview(highlightView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setShadeOpacity(progress: CGFloat) {
        shadeOpacity = progress
        updateShade()
        updateShadow()
    }

    
    func setZoom(progress: CGFloat) {
        zoom = progress
    }
    
    override var bounds: CGRect {
        didSet {
            guard latestBounds != bounds else { return }
            latestBounds = bounds
            highlightView.frame = bounds
            update()
        }
    }
    
    func configure(with text : String) {
        label.text = text
    }
    
    private func update() {
        updateShade()
        updateMask()
        updateShadow()
    }
    
    func updateShade() {
        shadeView.frame = bounds.insetBy(dx: -2, dy: -2)
        shadeView.alpha = 1 - shadeOpacity
    }
    
    func updateMask() {
        let mask = CAShapeLayer()
        let path =  UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        mask.path = path
        contentView.layer.mask = mask
    }
    
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            super.isHighlighted = newValue
            UIView.animate(withDuration: newValue ? 0 : 0.3) {
                self.highlightView.alpha = newValue ? 0.2 : 0
            }
        }
    }
    
    func updateShadow() {
        if layer.shadowPath == nil {
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            layer.shadowColor = shadowColor.cgColor
            layer.shadowRadius = shadowRadius
            layer.shadowOffset = shadowOffset
            layer.masksToBounds = false
        }
        layer.shadowOpacity = Float(shadowOpacity * shadeOpacity)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setShadeOpacity(progress: 0)
    }
    
    func getConstraint() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
}
