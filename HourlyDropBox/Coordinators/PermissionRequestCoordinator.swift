//
//  PermissionRequestCoordinator.swift
//  HourlyDropBox
//
//  Created by Andres Bocanumenth on 3/05/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

import UIKit

final class PermissionRequestCoordinator: Coordinator {
    
    //MARK: - Properties
    
    private let navigationController: UINavigationController
    
    //MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: - Public Methods
    
    func start() {
        let vc = PermissionRequestViewController()
        navigationController.viewControllers = [vc]
    }
}
