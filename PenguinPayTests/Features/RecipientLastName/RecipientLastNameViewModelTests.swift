//
//  RecipientLastNameViewModelTests.swift
//  PenguinPayTests
//
//  Created by Felipe Moreira Tarrio Bassi on 07/04/22.
//

import XCTest
@testable import PenguinPay

class RecipientLastNameViewModelTests: XCTestCase {
    
    let navigationController = UINavigationController()
    
    func testValidatelastNameWithInvalidLetter() {
        
        let spy = RecipientLastNameCoordinatorDelegateSpy()
        let sut = RecipientLastNameViewModel(coordinatorDelegate: spy)
        XCTAssertFalse(sut.validateLastName(" "), "Invalid typed string")
    }
    
    func testValidatelastNameWithValidLetter() {
        
        let spy = RecipientLastNameCoordinatorDelegateSpy()
        let sut = RecipientLastNameViewModel(coordinatorDelegate: spy)
        XCTAssertTrue(sut.validateLastName("B"), "Valid typed string")
    }
    
    func testDidFilllastName() {
        
        let spy = RecipientLastNameCoordinatorDelegateSpy()
        let sut = RecipientLastNameViewModel(coordinatorDelegate: spy)
        sut.didFillLastName("Bassi")
        XCTAssertTrue(sut.buttonState.value, "Valid Name")
    }
    
    func testDidFillWithEmptyStringlastName() {
        
        let spy = RecipientLastNameCoordinatorDelegateSpy()
        let sut = RecipientLastNameViewModel(coordinatorDelegate: spy)
        sut.didFillLastName("")
        XCTAssertFalse(sut.buttonState.value, "Invalid Name")
    }
}

class RecipientLastNameCoordinatorDelegateSpy: RecipientLastNameCoordinatorDelegate {
    private(set) var viewModelRecipientLastNameNextStepCalled = false
    func viewModelRecipientLastNameNextStep(_ viewModel: RecipientLastNameViewModel) {
        viewModelRecipientLastNameNextStepCalled = true
    }
}
