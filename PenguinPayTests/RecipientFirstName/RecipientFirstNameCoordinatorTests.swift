//
//  RecipientFirstName.swift
//  PenguinPayTests
//
//  Created by Felipe Moreira Tarrio Bassi on 05/04/22.
//

@testable import PenguinPay
import XCTest

class RecipientFirstNameCoordinatorTests: XCTestCase {

    let navigationController = UINavigationController()
    
    func testCoordinatorFlow() throws {
        let spy = RecipientFirstNameCoordinatorDelegateSpy()
        let viewModel = RecipientFirstNameViewModel(coordinatorDelegate: spy)
        let sut = RecipientFirstNameCoordinator(navigationController: navigationController, viewModel: viewModel)
        sut.start()
        XCTAssertFalse(navigationController.viewControllers.isEmpty, "After Coordinator start navigation controller should not be empty")
        viewModel.continueButtonTapped()
        XCTAssertTrue(spy.viewModelRecipientFirstNameNextStepCalled, "After continue button tapped, delegate methor should be called")
    }
}

class RecipientFirstNameCoordinatorDelegateSpy: RecipientFirstNameCoordinatorDelegate {
    var viewModelRecipientFirstNameNextStepCalled = false
    func viewModelRecipientFirstNameNextStep(_ viewModel: RecipientFirstNameViewModel) {
        viewModelRecipientFirstNameNextStepCalled = true
    }
}
