//
//  RecipientLastNameViewController.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import UIKit

class RecipientLastNameViewController: UIViewController {

    private static let separatorHeight: CGFloat = 1
    private static let buttonViewHeight: CGFloat = 96
    
    private lazy var buttonView: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: Self.buttonViewHeight)))
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
    
    private lazy var firstNameField: UITextField = { [weak self] in
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = viewModel.textFieldPlaceholder
        textField.borderStyle = .roundedRect
        textField.delegate = self
        return textField
    }()

    private var viewModel: RecipientLastNameViewModelProtocol
    
    init(viewModel: RecipientLastNameViewModelProtocol) {
        self.viewModel = viewModel
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
            buttonView.heightAnchor.constraint(equalToConstant: Self.buttonViewHeight)
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
        
        view.addSubview(firstNameField)
        NSLayoutConstraint.activate([
            firstNameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .spacing(.medium)),
            firstNameField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .spacing(.medium)),
            firstNameField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -.spacing(.medium))
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
    }
}

extension RecipientLastNameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let unwrappedText = textField.text else { return textField.resignFirstResponder() }
        viewModel.didFillLastName(unwrappedText)
        return textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return viewModel.validateLastName(string)
    }
}
