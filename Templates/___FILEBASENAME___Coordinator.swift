//
//  ___FILEHEADER___
//

import UIKit

class ___VARIABLE_productName:identifier___Coordinator: Coordinator {
    var viewModel: ___VARIABLE_productName:identifier___ViewModelProtocol
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, viewModel: ___VARIABLE_productName:identifier___ViewModelProtocol ) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        let viewController = ___VARIABLE_productName:identifier___ViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension ___VARIABLE_productName:identifier___Coordinator: ___VARIABLE_productName:identifier___CoordinatorDelegate {
    func viewModel___VARIABLE_productName:identifier:___DidSomething(_ viewModel: ___VARIABLE_productName:identifier___ViewModel) {
        // Do something
    }
}
