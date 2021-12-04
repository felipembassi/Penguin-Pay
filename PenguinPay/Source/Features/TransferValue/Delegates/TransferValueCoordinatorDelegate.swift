//
//  TransferValueCoordinatorDelegate.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import Foundation

protocol TransferValueCoordinatorDelegate: AnyObject {
    func viewModelTransferValueDidSomething(_ viewModel: TransferValueViewModel)
}
