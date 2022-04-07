//
//  RecipientLastNameCoordinator.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import UIKit

class RecipientLastNameCoordinator: Coordinator {
    var viewModel: RecipientLastNameViewModelProtocol
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, viewModel: RecipientLastNameViewModelProtocol) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        let viewController = RecipientLastNameViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
