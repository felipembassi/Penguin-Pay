//
//  String.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import Foundation

public enum LocalizableBundle: String {
    
    // MARK: - Texts
    
    // MARK: - Common
    case continueButtonTitle
    case editButtonTitle
    case sendButtonTitle
    case successAlertTitle
    case successMessage
    case okButtonTitle
    // MARK: - Splash
    case splashTitle
    // MARK: - Recipient First Name Screen
    case recipientFirstNameTitle
    case recipientFirstNameTextFieldPlaceholder
    // MARK: - Recipient Last Name Screen
    case recipientLastNameTitle
    case recipientLastNameTextFieldPlaceholder
    // MARK: - Recipient Select Country Screen
    case recipientCountryTitle
    case recipientCountryTextFieldPlaceholder
    // MARK: - Recipient Phone Screen
    case recipientPhoneTitle
    case recipientPhoneTextFieldPlaceholder
    // MARK: - Recipient Send Value Screen
    case recipientValueTitle
    case recipientValueTextFieldPlaceholder
    case valueSummaryTitle
    case valueSummaryBinariaSendingValueLabelTitle
    case valueSummaryCountrySendingValueLabelTitle
    
    // MARK: - Computed properties
    var localized: String {
        return rawValue.localize()
    }
}

extension String {
    
    /// Method responsable for returning the string on Localizable strings file
    /// - Returns: Localizable String
    func localize() -> String {
        return NSLocalizedString(self, tableName: "Localizable", value: "", comment: "")
    }
}
