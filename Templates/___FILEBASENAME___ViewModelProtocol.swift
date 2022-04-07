//
//  ___FILEHEADER___
//

import Foundation

protocol ___VARIABLE_productName:identifier___ViewModelProtocol {
    var coordinatorDelegate: ___VARIABLE_productName:identifier___CoordinatorDelegate? { get }
    var screenTitle: String { get }
    var buttonTitle: String { get }
    var textFieldPlaceholder: String { get }
    var buttonState: Observable<Bool> { get set }
    init(coordinatorDelegate: ___VARIABLE_productName:identifier___CoordinatorDelegate?)
    
    func continueButtonTapped()
}
