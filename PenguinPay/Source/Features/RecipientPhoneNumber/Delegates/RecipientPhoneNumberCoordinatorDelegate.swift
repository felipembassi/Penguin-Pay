//
//  RecipientPhoneNumberCoordinatorDelegate.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import Foundation

protocol RecipientPhoneNumberCoordinatorDelegate: AnyObject {
    func viewModelRecipientPhoneNumberFillPhoneNumber(_ viewModel: RecipientPhoneNumberViewModel, for country: Country)
}
