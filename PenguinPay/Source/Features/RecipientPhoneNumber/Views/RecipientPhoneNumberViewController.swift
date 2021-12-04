//
//  RecipientPhoneNumberViewController.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import UIKit

class RecipientPhoneNumberViewController: UIViewController {

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
    
    private lazy var countryPrefix: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: .size(.small), weight: .semibold)
        label.textColor = .black
        label.numberOfLines = .zero
        label.text = viewModel.country.phonePrefix
        return label
    }()
    
    private lazy var phoneField: UITextField = { [unowned self] in
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = viewModel.textFieldPlaceholder
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.delegate = self
        return textField
    }()

    private var viewModel: RecipientPhoneNumberViewModelProtocol
    
    init(viewModel: RecipientPhoneNumberViewModelProtocol) {
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
        setupGesture()
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
        
        view.addSubview(countryPrefix)
        NSLayoutConstraint.activate([
            countryPrefix.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .spacing(.medium)),
            countryPrefix.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .spacing(.medium)),
            countryPrefix.widthAnchor.constraint(equalToConstant: .size(.xLarge))
        ])
        
        view.addSubview(phoneField)
        NSLayoutConstraint.activate([
            phoneField.leadingAnchor.constraint(equalTo: countryPrefix.trailingAnchor, constant: .spacing(.nano)),
            phoneField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -.spacing(.medium)),
            phoneField.centerYAnchor.constraint(equalTo: countryPrefix.centerYAnchor)
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
    
    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tap)
    }
    
    @objc
    private func viewTapped() {
        readTextField()
        phoneField.resignFirstResponder()
    }
    
    private func readTextField() {
        guard let unwrappedText = phoneField.text else { return }
        viewModel.didFillPhoneNumber(unwrappedText)
    }
}

extension RecipientPhoneNumberViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        readTextField()
        return textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = viewModel.applyPhoneMask(toString: newString)
        return false
    }
}

