//
//  RecipientCountryCollectionViewCell.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import UIKit

class RecipientCountryCollectionViewCell: UICollectionViewCell {
    
    private let selectionColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    private let flagSize: CGFloat = 156
    
    private lazy var flag: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var countryName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: .size(.medium), weight: .semibold)
        label.textColor = .black
        label.numberOfLines = .zero
        label.textAlignment = .center
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? selectionColor : .clear
        }
    }
    
    private var viewModel: RecipientCountryCollectionViewCellModel? {
        didSet {
            flag.image = UIImage(named: viewModel?.imageName ?? "")
            countryName.text = viewModel?.countryName ?? ""
        }
    }
    
    public func set(viewModel: RecipientCountryCollectionViewCellModel) {
        self.viewModel = viewModel
        setupConstraints()
    }
    
    private func setupConstraints() {
        addSubview(flag)
        NSLayoutConstraint.activate([
            flag.centerXAnchor.constraint(equalTo: centerXAnchor),
            flag.centerYAnchor.constraint(equalTo: centerYAnchor),
            flag.heightAnchor.constraint(equalToConstant: flagSize),
            flag.widthAnchor.constraint(equalToConstant: flagSize)
        ])
        
        addSubview(countryName)
        NSLayoutConstraint.activate([
            countryName.topAnchor.constraint(equalTo: flag.bottomAnchor, constant: .spacing(.small)),
            countryName.leadingAnchor.constraint(equalTo: leadingAnchor),
            countryName.trailingAnchor.constraint(equalTo: trailingAnchor),
            countryName.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

