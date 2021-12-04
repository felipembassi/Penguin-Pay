//
//  TransferValueViewController.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import UIKit

class TransferValueViewController: UIViewController {
    
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
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = viewModel.textFieldPlaceholder
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.delegate = self
        return textField
    }()
    
    private lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: .size(.xBig), weight: .bold)
        label.textColor = .black
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.text = viewModel.summaryLabel
        return label
    }()
    
    private lazy var sendingValueTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: .size(.small), weight: .bold)
        label.textColor = .black
        label.numberOfLines = .zero
        label.text = viewModel.sendingValueLabelTitleText
        return label
    }()
    
    private lazy var sendingValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: .size(.small), weight: .bold)
        label.textColor = .black
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var receivingValueTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: .size(.small), weight: .bold)
        label.textColor = .black
        label.numberOfLines = .zero
        label.text = viewModel.receivingValueLabelTitleText
        return label
    }()
    
    private lazy var receivingValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: .size(.small), weight: .bold)
        label.textColor = .black
        label.numberOfLines = .zero
        return label
    }()
    
    private var viewModel: TransferValueViewModelProtocol
    
    init(viewModel: TransferValueViewModelProtocol) {
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
        
        view.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .spacing(.medium)),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .spacing(.medium)),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -.spacing(.medium))
        ])
        
        setupSummary()
    }
    
    private func setupSummary() {
        view.addSubview(summaryLabel)
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: .spacing(.medium)),
            summaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(sendingValueTitleLabel)
        NSLayoutConstraint.activate([
            sendingValueTitleLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: .spacing(.medium)),
            sendingValueTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .spacing(.medium)),
        ])
        
        view.addSubview(sendingValueLabel)
        NSLayoutConstraint.activate([
            sendingValueLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: .spacing(.medium)),
            sendingValueLabel.leadingAnchor.constraint(equalTo: sendingValueTitleLabel.trailingAnchor, constant: .spacing(.nano)),
            sendingValueLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -.spacing(.medium)),
        ])
        
        view.addSubview(receivingValueTitleLabel)
        NSLayoutConstraint.activate([
            receivingValueTitleLabel.topAnchor.constraint(equalTo: sendingValueTitleLabel.bottomAnchor, constant: .spacing(.medium)),
            receivingValueTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .spacing(.medium)),
        ])
        
        view.addSubview(receivingValueLabel)
        NSLayoutConstraint.activate([
            receivingValueLabel.topAnchor.constraint(equalTo: sendingValueLabel.bottomAnchor, constant: .spacing(.medium)),
            receivingValueLabel.leadingAnchor.constraint(equalTo: receivingValueTitleLabel.trailingAnchor, constant: .spacing(.nano)),
            receivingValueLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -.spacing(.medium)),
        ])
        
    }
    
    private func setupSubViewContents() {
        view.backgroundColor = .brandColorBackground
        title = viewModel.screenTitle
        viewModel.fetchExchangeRates()
    }
    
    private func bindingElements() {
        viewModel.buttonState.bind { [unowned self] isEnable in
            nextStepButton.isEnabled = isEnable
        }
        
        viewModel.exchangeRate.bind { [unowned self] receivingValue in
            receivingValueLabel.text = receivingValue
        }
    }
    
    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tap)
    }
    
    @objc
    private func viewTapped() {
        readTextField()
        textField.resignFirstResponder()
    }
    
    private func readTextField() {
        guard let unwrappedText = textField.text else { return }
        viewModel.didFillValue(unwrappedText)
        sendingValueLabel.text = unwrappedText
    }
}

extension TransferValueViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        readTextField()
        return textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let newValue = viewModel.validateTextFieldText(text, withString: string, In: range) else { return false }
        textField.text = newValue
        return false
    }
}

