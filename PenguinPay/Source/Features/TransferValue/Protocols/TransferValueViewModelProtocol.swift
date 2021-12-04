//
//  TransferValueViewModelProtocol.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import Foundation

protocol TransferValueViewModelProtocol {
    var coordinatorDelegate: TransferValueCoordinatorDelegate? { get }
    var country: Country { get }
    var screenTitle: String { get }
    var buttonTitle: String { get }
    var textFieldPlaceholder: String { get }
    var buttonState: Observable<Bool> { get set }
    var exchangeRate: Observable<String> { get set }
    var summaryLabel: String { get }
    var sendingValueLabelTitleText: String { get }
    var receivingValueLabelTitleText: String { get }
    init(coordinatorDelegate: TransferValueCoordinatorDelegate?, country: Country)
    
    func continueButtonTapped()
    func validateTextFieldText(_ text: String, withString string: String, In range: NSRange) -> String?
    func fetchExchangeRates()
    func didFillValue(_ value: String)
}
