//
//  MainCoordinatorTests.swift
//  PenguinPayTests
//
//  Created by Felipe Moreira Tarrio Bassi on 06/04/22.
//

import XCTest
@testable import PenguinPay

class MainCoordinatorTests: XCTestCase {

    lazy var navigationController = UINavigationController()
    lazy var sut = MainCoordinator(navigationController: navigationController)
    let country = Country(name: "Kenya", currency: "KES", phonePrefix: "+254", phoneNumberDigits: 9, imageName: "ic-kenya")
    var window = UIWindow()
    func testMainCoordinatorStart() {
        sut.start()
        XCTAssertFalse(navigationController.viewControllers.isEmpty, "After Coordinator start navigation controller should not be empty")
        XCTAssertTrue(navigationController.viewControllers.first is RecipientFirstNameViewController)
    }
    
    func testRecipientFirstNameCoordinatorDelegate() {
        sut.recipientFirstNameViewModel.continueButtonTapped()
        XCTAssertTrue(navigationController.viewControllers.last is RecipientLastNameViewController)
    }
    
    func testRecipientLastNameCoordinatorDelegate() {
        sut.recipientLastNameViewModel.continueButtonTapped()
        XCTAssertTrue(navigationController.viewControllers.last is RecipientCountrySelectionViewController)
    }
    
    func testRecipientCountrySelectionCoordinatorDelegate() {
        sut.recipientCountrySelectionViewModel.didSelectCounty(country)
        sut.recipientCountrySelectionViewModel.continueButtonTapped()
        XCTAssertTrue(navigationController.viewControllers.last is RecipientPhoneNumberViewController)
    }
    
    func testRecipientPhoneNumberCoordinatorDelegate() {
        sut.recipientPhoneNumberViewModel = RecipientPhoneNumberViewModel(coordinatorDelegate: sut, country: country)
        sut.recipientPhoneNumberViewModel?.continueButtonTapped()
        XCTAssertTrue(navigationController.viewControllers.last is TransferValueViewController)
    }
}
