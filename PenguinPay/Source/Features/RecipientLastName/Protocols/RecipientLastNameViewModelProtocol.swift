//
//  RecipientLastNameViewModelProtocol.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import Foundation

protocol RecipientLastNameViewModelProtocol: AnyObject {
    var coordinatorDelegate: RecipientLastNameCoordinatorDelegate? { get }
    var screenTitle: String { get }
    var buttonTitle: String { get }
    var textFieldPlaceholder: String { get }
    var buttonState: Observable<Bool> { get set }
    
    func continueButtonTapped()
    func validateLastName(_ name: String) -> Bool
    func didFillLastName(_ name: String)
}
