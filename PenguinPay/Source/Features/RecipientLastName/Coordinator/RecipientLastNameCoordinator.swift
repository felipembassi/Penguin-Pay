//
//  RecipientLastNameCoordinator.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import UIKit

class RecipientLastNameCoordinator: Coordinator {
    weak var parentCoordinatorDelegate: RecipientLastNameCoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, parentCoordinatorDelegate: RecipientLastNameCoordinatorDelegate?) {
        self.navigationController = navigationController
        self.parentCoordinatorDelegate = parentCoordinatorDelegate
    }
    
    func start() {
        let viewModel = RecipientLastNameViewModel(coordinatorDelegate: parentCoordinatorDelegate)
        let viewController = RecipientLastNameViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
