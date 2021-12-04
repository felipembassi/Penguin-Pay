//
//  RecipientFirstNameViewModelProtocol.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import Foundation

protocol RecipientFirstNameViewModelProtocol: AnyObject {
    var coordinatorDelegate: RecipientFirstNameCoordinatorDelegate? { get }
    var screenTitle: String { get }
    var buttonTitle: String { get }
    var textFieldPlaceholder: String { get }
    var buttonState: Observable<Bool> { get set }
    
    func continueButtonTapped()
    func validateFirstName(_ name: String) -> Bool
    func didFillFirstName(_ name: String)
}
