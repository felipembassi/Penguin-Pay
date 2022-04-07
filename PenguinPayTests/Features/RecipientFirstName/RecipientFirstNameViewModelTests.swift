//
//  RecipientFirstNameViewModelTests.swift
//  PenguinPayTests
//
//  Created by Felipe Moreira Tarrio Bassi on 07/04/22.
//

import XCTest
@testable import PenguinPay

class RecipientFirstNameViewModelTests: XCTestCase {
    
    let navigationController = UINavigationController()
    
    func testValidateFirstNameWithInvalidLetter() {
        
        let spy = RecipientFirstNameCoordinatorDelegateSpy()
        let sut = RecipientFirstNameViewModel(coordinatorDelegate: spy)
        XCTAssertFalse(sut.validateFirstName(" "), "Invalid typed string")
    }
    
    func testValidateFirstNameWithValidLetter() {
        
        let spy = RecipientFirstNameCoordinatorDelegateSpy()
        let sut = RecipientFirstNameViewModel(coordinatorDelegate: spy)
        XCTAssertTrue(sut.validateFirstName("F"), "Valid typed string")
    }
    
    func testDidFillFirstName() {
        
        let spy = RecipientFirstNameCoordinatorDelegateSpy()
        let sut = RecipientFirstNameViewModel(coordinatorDelegate: spy)
        sut.didFillFirstName("Felipe")
        XCTAssertTrue(sut.buttonState.value, "Valid Name")
    }
    
    func testDidFillWithEmptyStringFirstName() {
        
        let spy = RecipientFirstNameCoordinatorDelegateSpy()
        let sut = RecipientFirstNameViewModel(coordinatorDelegate: spy)
        sut.didFillFirstName("")
        XCTAssertFalse(sut.buttonState.value, "Invalid Name")
    }
}

class RecipientFirstNameCoordinatorDelegateSpy: RecipientFirstNameCoordinatorDelegate {
    private(set) var viewModelRecipientFirstNameNextStepCalled = false
    func viewModelRecipientFirstNameNextStep(_ viewModel: RecipientFirstNameViewModel) {
        viewModelRecipientFirstNameNextStepCalled = true
    }
}
