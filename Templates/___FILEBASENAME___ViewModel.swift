//
//  ___FILEHEADER___
//

import UIKit

class ___VARIABLE_productName:identifier___ViewModel: ___VARIABLE_productName:identifier___ViewModelProtocol {
    weak var coordinatorDelegate: ___VARIABLE_productName:identifier___CoordinatorDelegate?
    
    var screenTitle: String {
        ""
    }
    
    var buttonTitle: String {
        ""
    }

    var textFieldPlaceholder: String {
        ""
    }

    var buttonState = Observable<Bool>(false)

    required init(coordinatorDelegate: ___VARIABLE_productName:identifier___CoordinatorDelegate?) {
        self.coordinatorDelegate = coordinatorDelegate
    }

    func continueButtonTapped() {
        coordinatorDelegate?.viewModel___VARIABLE_productName:identifier:___DidSomething(self)
    }
}
