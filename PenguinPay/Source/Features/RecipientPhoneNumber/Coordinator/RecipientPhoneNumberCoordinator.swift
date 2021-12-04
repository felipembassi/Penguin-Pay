//
//  RecipientPhoneNumberCoordinator.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import UIKit

class RecipientPhoneNumberCoordinator: Coordinator {
    weak var parentCoordinatorDelegate: RecipientPhoneNumberCoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var country: Country
    
    init(navigationController: UINavigationController, parentCoordinatorDelegate: RecipientPhoneNumberCoordinatorDelegate?, country: Country) {
        self.navigationController = navigationController
        self.parentCoordinatorDelegate = parentCoordinatorDelegate
        self.country = country
    }
    
    func start() {
        let viewModel = RecipientPhoneNumberViewModel(coordinatorDelegate: parentCoordinatorDelegate, country: country)
        let viewController = RecipientPhoneNumberViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
