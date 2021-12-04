//
//  RecipientFirstNameViewModel.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import UIKit

class RecipientFirstNameViewModel: RecipientFirstNameViewModelProtocol {
    weak var coordinatorDelegate: RecipientFirstNameCoordinatorDelegate?
    
    var screenTitle: String {
        LocalizableBundle.recipientFirstNameTitle.localized
    }
    
    var buttonTitle: String {
        LocalizableBundle.continueButtonTitle.localized
    }
    
    var textFieldPlaceholder: String {
        LocalizableBundle.recipientFirstNameTextFieldPlaceholder.localized
    }
    
    var buttonState = Observable<Bool>(false)

    init(coordinatorDelegate: RecipientFirstNameCoordinatorDelegate?) {
        self.coordinatorDelegate = coordinatorDelegate
    }
    
    func continueButtonTapped() {
        coordinatorDelegate?.viewModelRecipientFirstNameNextStep(self)
    }
    
    func validateFirstName(_ name: String) -> Bool {
        if name == " " {
            return false
        }
        return true
    }
    
    func didFillFirstName(_ name: String) {
        buttonState.value = !name.isEmpty
    }
}

