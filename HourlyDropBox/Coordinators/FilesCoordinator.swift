//
//  FilesCoordinator.swift
//  HourlyDropBox
//
//  Created by Andres Bocanumenth on 3/05/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

import UIKit

final class FilesCoordinator: Coordinator {
    
    //MARK: - Properties
    
    private let navigationController: UINavigationController
    
    //MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: - Public Methods
    
    func start() {
        let viewModel = FilesViewModel(coordinator: self)
        let vc = FilesViewController(viewModel: viewModel)
        navigationController.viewControllers = [vc]
    }
    
    func navigateToPath(_ entry: DropboxEntry) {
        let vc = FilesViewController(viewModel: FilesViewModel(path: entry.path ?? "", title: entry.name, coordinator: self))
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showFile(entry: DropboxEntry) {
        var vc = UIViewController()
        switch entry.fileType {
            case .image:
                vc = ImageViewerViewController(entry: entry)
            case .pdf:
                vc = PDFViewerViewController(entry: entry)
            default:
                return
        }
        navigationController.pushViewController(vc, animated: true)
    }
}
