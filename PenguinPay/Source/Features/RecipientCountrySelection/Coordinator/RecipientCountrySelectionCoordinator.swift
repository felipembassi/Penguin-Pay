//
//  RecipientCountrySelectionCoordinator.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import UIKit

class RecipientCountrySelectionCoordinator: Coordinator {
    weak var parentCoordinatorDelegate: RecipientCountrySelectionCoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, parentCoordinatorDelegate: RecipientCountrySelectionCoordinatorDelegate?) {
        self.navigationController = navigationController
        self.parentCoordinatorDelegate = parentCoordinatorDelegate
    }
    
    func start() {
        let viewModel = RecipientCountrySelectionViewModel(coordinatorDelegate: parentCoordinatorDelegate)
        let dataSource = RecipientCountryCollectionViewManager(viewModel: viewModel)
        let viewController = RecipientCountrySelectionViewController(viewModel: viewModel, collectionViewManager: dataSource)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
