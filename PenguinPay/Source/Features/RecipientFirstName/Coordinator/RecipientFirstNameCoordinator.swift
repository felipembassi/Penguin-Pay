//
//  RecipientFirstNameCoordinator.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import UIKit

class RecipientFirstNameCoordinator: Coordinator {
    var viewModel: RecipientFirstNameViewModelProtocol
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, viewModel: RecipientFirstNameViewModelProtocol) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        let viewController = RecipientFirstNameViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
