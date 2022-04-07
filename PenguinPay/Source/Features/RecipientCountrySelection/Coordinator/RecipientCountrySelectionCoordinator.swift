//
//  RecipientCountrySelectionCoordinator.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import UIKit

class RecipientCountrySelectionCoordinator: Coordinator {
    var viewModel: RecipientCountrySelectionViewModelProtocol
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, viewModel: RecipientCountrySelectionViewModelProtocol) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        let dataSource = RecipientCountryCollectionViewManager(viewModel: viewModel)
        let viewController = RecipientCountrySelectionViewController(viewModel: viewModel, collectionViewManager: dataSource)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
