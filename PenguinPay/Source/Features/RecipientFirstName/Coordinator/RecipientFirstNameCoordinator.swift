//
//  RecipientFirstNameCoordinator.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import UIKit

class RecipientFirstNameCoordinator: Coordinator {
    weak var parentCoordinatorDelegate: RecipientFirstNameCoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, parentCoordinatorDelegate: RecipientFirstNameCoordinatorDelegate) {
        self.navigationController = navigationController
        self.parentCoordinatorDelegate = parentCoordinatorDelegate
    }
    
    func start() {
        let viewModel = RecipientFirstNameViewModel(coordinatorDelegate: parentCoordinatorDelegate)
        let viewController = RecipientFirstNameViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
