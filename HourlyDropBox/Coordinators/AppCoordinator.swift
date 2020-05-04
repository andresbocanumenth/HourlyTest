//
//  AppCoordinator.swift
//  HourlyDropBox
//
//  Created by Andres Bocanumenth on 1/05/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

import UIKit

protocol Coordinator {
    init(navigationController: UINavigationController)
}

final class AppCoordinator {
    
    //MARK: - Properties
    
    private let window: UIWindow
    private let navigationController = UINavigationController()
    
    //MARK: - Init
    
    init(window: UIWindow) {
        self.window = window
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.tintColor = .black
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    //MARK: - Public Methods
    
    func start() {
        if DropboxManager.shared.dropBoxUser != nil {
            startLoggedUser()
        } else {
            startPermissionRequest()
        }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    //MARK: - Private Methods
    
    private func startLoggedUser() {
        let filesCoordinator = FilesCoordinator(navigationController: navigationController)
        filesCoordinator.start()
    }
    
    private func startPermissionRequest() {
        let permissionRequest = PermissionRequestCoordinator(navigationController: navigationController)
        permissionRequest.start()
    }
}
