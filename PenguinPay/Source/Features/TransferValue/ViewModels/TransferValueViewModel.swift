//
//  TransferValueViewModel.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import UIKit

class TransferValueViewModel: TransferValueViewModelProtocol {
    weak var coordinatorDelegate: TransferValueCoordinatorDelegate?
    var country: Country
    
    var screenTitle: String {
        LocalizableBundle.recipientValueTitle.localized
    }
    
    var buttonTitle: String {
        LocalizableBundle.sendButtonTitle.localized
    }

    var textFieldPlaceholder: String {
        LocalizableBundle.recipientValueTextFieldPlaceholder.localized
    }

    var buttonState = Observable<Bool>(false)
    var exchangeRate = Observable<String>("")
    var summaryLabel: String {
        LocalizableBundle.valueSummaryTitle.localized
    }
    
    var sendingValueLabelTitleText: String {
        LocalizableBundle.valueSummaryBinariaSendingValueLabelTitle.localized
    }
    
    var receivingValueLabelTitleText: String {
        String(format: LocalizableBundle.valueSummaryCountrySendingValueLabelTitle.localized, country.currency)
    }
    
    private var countryExchangeRate: Double?

    required init(coordinatorDelegate: TransferValueCoordinatorDelegate?, country: Country) {
        self.coordinatorDelegate = coordinatorDelegate
        self.country = country
    }
    
    let worker = APIWorker<OpenExchangeRatesEndpoint>()

    func continueButtonTapped() {
        coordinatorDelegate?.viewModelTransferValueDidSomething(self)
    }
    
    func validateTextFieldText(_ text: String, withString string: String, In range: NSRange) -> String? {
        if string == "1" || string == "0" || string.isEmpty {
            return (text as NSString).replacingCharacters(in: range, with: string)
        }
        
        return nil
    }
    
    func fetchExchangeRates() {
        worker.request(.rates, expecting: OpenExchangeRates.self) { [unowned self] result in
            switch result {
                case .success(let openExchangeRates):
                    countryExchangeRate = openExchangeRates.rates?[country.currency]
                case .failure(let error):
                    debugPrint(error)
            }
        }
    }
    
    func didFillValue(_ value: String) {
        if let number = Int(value, radix: 2), let currentExchangeRate = countryExchangeRate {
            let result = number * Int(round(currentExchangeRate))
            let binaryResult = String(result, radix: 2)
            buttonState.value = !binaryResult.isEmpty
            exchangeRate.value = binaryResult
            
        }
    }
}

