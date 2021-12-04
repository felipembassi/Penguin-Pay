//
//  RecipientCountrySelectionViewModelProtocol.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import Foundation

protocol RecipientCountrySelectionViewModelProtocol: AnyObject {
    var coordinatorDelegate: RecipientCountrySelectionCoordinatorDelegate? { get }
    var screenTitle: String { get }
    var buttonTitle: String { get }
    var buttonState: Observable<Bool> { get set }
    var countries: Observable<[Country]> { get }
    var numberOfRows: Int { get }
    var selectedCountry: Country? { get }
    
    func continueButtonTapped()
    func getCellModel(for indexPath: IndexPath) -> RecipientCountryCollectionViewCellModel
    func didSelectCounty(_ country: Country)
}
