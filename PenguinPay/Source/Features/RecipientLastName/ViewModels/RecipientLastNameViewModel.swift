//
//  RecipientLastNameViewModel.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import UIKit

class RecipientLastNameViewModel: RecipientLastNameViewModelProtocol {
    weak var coordinatorDelegate: RecipientLastNameCoordinatorDelegate?
    
    var screenTitle: String {
        LocalizableBundle.recipientLastNameTitle.localized
    }
    
    var buttonTitle: String {
        LocalizableBundle.continueButtonTitle.localized
    }
    
    var textFieldPlaceholder: String {
        LocalizableBundle.recipientLastNameTextFieldPlaceholder.localized
    }
    
    var buttonState = Observable<Bool>(false)

    init(coordinatorDelegate: RecipientLastNameCoordinatorDelegate?) {
        self.coordinatorDelegate = coordinatorDelegate
    }
    
    func continueButtonTapped() {
        coordinatorDelegate?.viewModelRecipientLastNameNextStep(self)
    }
    
    func validateLastName(_ name: String) -> Bool {
        if name == " " {
            return false
        }
        return true
    }
    
    func didFillLastName(_ name: String) {
        buttonState.value = !name.isEmpty
    }
}
