//
//  MainCoordinator.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    lazy var recipientFirstNameViewModel: RecipientFirstNameViewModelProtocol = RecipientFirstNameViewModel(coordinatorDelegate: self)
    
    lazy var recipientLastNameViewModel: RecipientLastNameViewModelProtocol = RecipientLastNameViewModel(coordinatorDelegate: self)
    
    lazy var recipientCountrySelectionViewModel: RecipientCountrySelectionViewModelProtocol = RecipientCountrySelectionViewModel(coordinatorDelegate: self)
    
    lazy var dataSource: RecipientCountryCollectionViewManager = RecipientCountryCollectionViewManager(viewModel: recipientCountrySelectionViewModel)
    
    var recipientPhoneNumberViewModel: RecipientPhoneNumberViewModelProtocol?
    
    var transferValueViewModel: TransferValueViewModelProtocol?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = RecipientFirstNameViewController(viewModel: recipientFirstNameViewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}


extension MainCoordinator: RecipientFirstNameCoordinatorDelegate {
    
    func viewModelRecipientFirstNameNextStep(_ viewModel: RecipientFirstNameViewModel) {
        let viewController = RecipientLastNameViewController(viewModel: recipientLastNameViewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension MainCoordinator: RecipientLastNameCoordinatorDelegate {
    func viewModelRecipientLastNameNextStep(_ viewModel: RecipientLastNameViewModel) {
        let viewController = RecipientCountrySelectionViewController(viewModel: recipientCountrySelectionViewModel, collectionViewManager: dataSource)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension MainCoordinator: RecipientCountrySelectionCoordinatorDelegate {
    func viewModelRecipientCountrySelection(_ viewModel: RecipientCountrySelectionViewModel, didSelectCountry country: Country) {
        recipientPhoneNumberViewModel = RecipientPhoneNumberViewModel(coordinatorDelegate: self, country: country)
        guard let unwrappedRecipientPhoneNumberViewModelviewModel = recipientPhoneNumberViewModel else { return }
        let viewController = RecipientPhoneNumberViewController(viewModel: unwrappedRecipientPhoneNumberViewModelviewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension MainCoordinator: RecipientPhoneNumberCoordinatorDelegate {
    func viewModelRecipientPhoneNumberFillPhoneNumber(_ viewModel: RecipientPhoneNumberViewModel, for country: Country) {
        transferValueViewModel = TransferValueViewModel(coordinatorDelegate: self, country: country)
        guard let unwrappedTransferValueViewModel = transferValueViewModel else { return }
        let viewController = TransferValueViewController(viewModel: unwrappedTransferValueViewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension MainCoordinator: TransferValueCoordinatorDelegate {
    func viewModelTransferValueDidSomething(_ viewModel: TransferValueViewModel) {
        let alert = UIAlertController(title: LocalizableBundle.successAlertTitle.localized, message: LocalizableBundle.successMessage.localized, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: LocalizableBundle.okButtonTitle.localized, style: .default) { [weak self] _ in
            self?.childCoordinators.removeAll()
            self?.navigationController.viewControllers.removeAll()
            self?.start()
        })

        navigationController.present(alert, animated: true)
        
    }
}
