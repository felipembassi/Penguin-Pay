//
//  RecipientCountrySelectionViewController.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import UIKit

class RecipientCountrySelectionViewController: UIViewController {

    private static let separatorHeight: CGFloat = 1
    
    private lazy var buttonView: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: .size(.xxxxxxLarge))))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: Self.separatorHeight)))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var nextStepButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .systemGreen
        configuration.buttonSize = .large
        var attText = AttributedString.init(viewModel.buttonTitle)
        attText.font = UIFont.systemFont(ofSize: .size(.small), weight: .bold)
        configuration.attributedTitle = attText

        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { [ unowned self ] _ in
            viewModel.continueButtonTapped()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        return button
    }()
    
    private lazy var collection: UICollectionView = { [weak self] in
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionHeadersPinToVisibleBounds = true
        flowLayout.minimumInteritemSpacing = .spacing(.small)
        flowLayout.minimumLineSpacing = .spacing(.small)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        collectionView.backgroundColor = .brandColorBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsMultipleSelection = false
        collectionView.keyboardDismissMode = .onDrag
        collectionView.bounces = false
        collectionView.dataSource = collectionViewManager
        collectionView.delegate = collectionViewManager
        collectionView.register(RecipientCountryCollectionViewCell.self, forCellWithReuseIdentifier: RecipientCountryCollectionViewCell.className)
        return collectionView
    }()

    private var viewModel: RecipientCountrySelectionViewModelProtocol
    private var collectionViewManager: RecipientCountryCollectionViewManager
    
    init(viewModel: RecipientCountrySelectionViewModelProtocol, collectionViewManager: RecipientCountryCollectionViewManager) {
        self.viewModel = viewModel
        self.collectionViewManager = collectionViewManager
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupSubViewContents()
        bindingElements()
    }
    
    // MARK: - Privates
    
    private func setupConstraints() {
        view.addSubview(buttonView)
        NSLayoutConstraint.activate([
            buttonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            buttonView.heightAnchor.constraint(equalToConstant: .size(.xxxxxxLarge))
        ])
        
        buttonView.addSubview(separatorView)
        NSLayoutConstraint.activate([
            separatorView.bottomAnchor.constraint(equalTo: buttonView.topAnchor),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: Self.separatorHeight)
        ])
        
        buttonView.addSubview(nextStepButton)
        NSLayoutConstraint.activate([
            nextStepButton.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: .spacing(.medium)),
            nextStepButton.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor, constant: .spacing(.medium)),
            nextStepButton.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor, constant: -.spacing(.medium)),
            nextStepButton.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: -.spacing(.medium))
        ])
        
        view.addSubview(collection)
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .spacing(.medium)),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .spacing(.medium)),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.spacing(.medium)),
            collection.bottomAnchor.constraint(equalTo: buttonView.topAnchor, constant: -.spacing(.medium))
        ])
        
    }
    
    private func setupSubViewContents() {
        view.backgroundColor = .brandColorBackground
        title = viewModel.screenTitle
    }
    
    private func bindingElements() {
        viewModel.buttonState.bind { [unowned self] isEnable in
            nextStepButton.isEnabled = isEnable
        }
        
        viewModel.countries.bind { [unowned self] countries in
            collection.reloadData()
        }
    }
}

