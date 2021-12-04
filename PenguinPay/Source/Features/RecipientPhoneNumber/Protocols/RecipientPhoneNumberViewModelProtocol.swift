//
//  RecipientPhoneNumberViewModelProtocol.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import Foundation

protocol RecipientPhoneNumberViewModelProtocol {
    var coordinatorDelegate: RecipientPhoneNumberCoordinatorDelegate? { get }
    var country: Country { get }
    var screenTitle: String { get }
    var buttonTitle: String { get }
    var textFieldPlaceholder: String { get }
    var buttonState: Observable<Bool> { get set }
    var mask: String { get }
    var filledPhone: String? { get }
    
    init(coordinatorDelegate: RecipientPhoneNumberCoordinatorDelegate?, country: Country)
    
    func continueButtonTapped()
    func applyPhoneMask(toString string: String) -> String
    func didFillPhoneNumber(_ phone: String)
}
