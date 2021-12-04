//
//  RecipientCountrySelectionCoordinatorDelegate.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import Foundation

protocol RecipientCountrySelectionCoordinatorDelegate: AnyObject {
    func viewModelRecipientCountrySelection(_ viewModel: RecipientCountrySelectionViewModel, didSelectCountry country: Country)
}
