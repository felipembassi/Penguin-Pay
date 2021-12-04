//
//  RecipientCountrySelectionViewModel.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import UIKit

class RecipientCountrySelectionViewModel: RecipientCountrySelectionViewModelProtocol {
    weak var coordinatorDelegate: RecipientCountrySelectionCoordinatorDelegate?
    
    var screenTitle: String {
        LocalizableBundle.recipientCountryTitle.localized
    }
    
    var buttonTitle: String {
        LocalizableBundle.continueButtonTitle.localized
    }
    
    // These strings are here and not on Localizable becasue I thought on the future this array will be populated from a API Service and not from bundle
    var countries = Observable<[Country]>([
        Country(name: "Kenya", currency: "KES", phonePrefix: "+254", phoneNumberDigits: 9, imageName: "ic-kenya"),
        Country(name: "Nigeria", currency: "NGN", phonePrefix: "+234", phoneNumberDigits: 7, imageName: "ic-nigeria"),
        Country(name: "Tanzania", currency: "TZS", phonePrefix: "+255", phoneNumberDigits: 9, imageName: "ic-tanzania"),
        Country(name: "Uganda", currency: "UGX", phonePrefix: "+256", phoneNumberDigits: 7, imageName: "ic-uganda")
    ])
    
    private var cellModels: [RecipientCountryCollectionViewCellModel] {
        return countries.value.compactMap { country in
            return RecipientCountryCollectionViewCellModel(imageName: country.imageName, countryName: country.name)
        }
    }
    
    var buttonState = Observable<Bool>(false)
    var selectedCountry: Country?
    
    var numberOfRows: Int {
        countries.value.count
    }

    init(coordinatorDelegate: RecipientCountrySelectionCoordinatorDelegate?) {
        self.coordinatorDelegate = coordinatorDelegate
    }

    func continueButtonTapped() {
        guard let unwrappedSelectedCountry = selectedCountry else { return }
        coordinatorDelegate?.viewModelRecipientCountrySelection(self, didSelectCountry: unwrappedSelectedCountry)
    }
    
    func getCellModel(for indexPath: IndexPath) -> RecipientCountryCollectionViewCellModel {
        cellModels[indexPath.row]
    }
    
    func didSelectCounty(_ country: Country) {
        selectedCountry = country
        buttonState.value = true
    }
}

