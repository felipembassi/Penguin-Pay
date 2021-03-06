//
//  CoordinatorProtocol.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
