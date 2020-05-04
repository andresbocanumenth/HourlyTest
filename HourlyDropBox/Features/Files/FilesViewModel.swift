//
//  FilesViewModel.swift
//  HourlyDropBox
//
//  Created by Andres Bocanumenth on 2/05/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

import Foundation

class FilesViewModel {
    
    //MARK: - Properties
    
    var filesDidLoad: (() -> Void)?
    var entries: [DropboxEntry] = []
    var title: String
    private let coordinator: FilesCoordinator
    private let path: String
    
    //MARK: - Init
    
    init(path: String? = "", title: String? = "Files", coordinator: FilesCoordinator) {
        self.path = path ?? ""
        self.title = title ?? ""
        self.coordinator = coordinator
    }
    
    //MARK: - Public Methods
    
    func fetchData() {
        DropboxManager.shared.fetchFilesFromPath(path: path) {[weak self] (entries) in
            guard let self = self,
                let entries = entries else {
                return
            }
            self.entries = entries
            self.filesDidLoad?()
        }
    }
    
    func entryTapped(_ indexPath: IndexPath) {
        let entry = entries[indexPath.row]
        switch entry.fileType {
            case .folder:
                coordinator.navigateToPath(entry)
            default:
                coordinator.showFile(entry: entry)
        }
    }
}
