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

    var recipient: Recipient?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let child = RecipientFirstNameCoordinator(navigationController: navigationController, parentCoordinatorDelegate: self)
        childCoordinators.append(child)
        child.start()
    }
}


extension MainCoordinator: RecipientFirstNameCoordinatorDelegate {
    func viewModelRecipientFirstNameNextStep(_ viewModel: RecipientFirstNameViewModel) {
        let child = RecipientLastNameCoordinator(navigationController: navigationController, parentCoordinatorDelegate: self)
        childCoordinators.append(child)
        child.start()
    }
}

extension MainCoordinator: RecipientLastNameCoordinatorDelegate {
    func viewModelRecipientLastNameNextStep(_ viewModel: RecipientLastNameViewModel) {
        let child = RecipientCountrySelectionCoordinator(navigationController: navigationController, parentCoordinatorDelegate: self)
        childCoordinators.append(child)
        child.start()
    }
}

extension MainCoordinator: RecipientCountrySelectionCoordinatorDelegate {
    func viewModelRecipientCountrySelection(_ viewModel: RecipientCountrySelectionViewModel, didSelectCountry country: Country) {
        let child = RecipientPhoneNumberCoordinator(navigationController: navigationController, parentCoordinatorDelegate: self, country: country)
        childCoordinators.append(child)
        child.start()
    }
}

extension MainCoordinator: RecipientPhoneNumberCoordinatorDelegate {
    func viewModelRecipientPhoneNumberFillPhoneNumber(_ viewModel: RecipientPhoneNumberViewModel, for country: Country) {
        let child = TransferValueCoordinator(navigationController: navigationController, parentCoordinatorDelegate: self, country: country)
        childCoordinators.append(child)
        child.start()
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
