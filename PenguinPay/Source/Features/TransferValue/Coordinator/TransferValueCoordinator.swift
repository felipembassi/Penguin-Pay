//
//  TransferValueCoordinator.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import UIKit

class TransferValueCoordinator: Coordinator {
    weak var parentCoordinatorDelegate: TransferValueCoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var country: Country
    
    init(navigationController: UINavigationController, parentCoordinatorDelegate: TransferValueCoordinatorDelegate?, country: Country) {
        self.navigationController = navigationController
        self.parentCoordinatorDelegate = parentCoordinatorDelegate
        self.country = country
    }
    
    func start() {
        let viewModel = TransferValueViewModel(coordinatorDelegate: parentCoordinatorDelegate, country: country)
        let viewController = TransferValueViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
