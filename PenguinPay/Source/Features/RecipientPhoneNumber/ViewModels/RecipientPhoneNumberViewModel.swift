//
//  RecipientPhoneNumberViewModel.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import UIKit

class RecipientPhoneNumberViewModel: RecipientPhoneNumberViewModelProtocol {
    weak var coordinatorDelegate: RecipientPhoneNumberCoordinatorDelegate?
    var country: Country
    
    var screenTitle: String {
        LocalizableBundle.recipientCountryTitle.localized
    }
    
    var buttonTitle: String {
        LocalizableBundle.continueButtonTitle.localized
    }

    var textFieldPlaceholder: String {
        LocalizableBundle.recipientPhoneTextFieldPlaceholder.localized
    }

    var buttonState = Observable<Bool>(false)
    
    private let phoneNumberMaskDigits = 3
    
    var mask: String {
        var mask = ""
        for index in 0...country.phoneNumberDigits + phoneNumberMaskDigits {
            switch index {
                case 0:
                    mask.append("(")
                case 3:
                    mask.append(")")
                case 4:
                    mask.append(" ")
                case 8:
                    mask.append("-")
                default:
                    mask.append("X")
            }
        }
        return mask
    }
    
    var filledPhone: String?

    required init(coordinatorDelegate: RecipientPhoneNumberCoordinatorDelegate?, country: Country) {
        self.coordinatorDelegate = coordinatorDelegate
        self.country = country
    }

    func continueButtonTapped() {
        coordinatorDelegate?.viewModelRecipientPhoneNumberFillPhoneNumber(self, for: country)
    }
    
    func applyPhoneMask(toString string: String) -> String {
        let numbers = string.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
                
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func didFillPhoneNumber(_ phone: String) {
        filledPhone = phone
        buttonState.value = phone.count >= country.phoneNumberDigits + phoneNumberMaskDigits
    }
}

