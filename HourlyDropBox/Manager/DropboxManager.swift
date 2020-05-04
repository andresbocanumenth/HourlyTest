//
//  DropboxManager.swift
//  HourlyDropBox
//
//  Created by Andres Bocanumenth on 1/05/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

import SwiftyDropbox

class DropboxManager {
    
    //MARK: - Properties
    
    public static let shared = DropboxManager()
    private let dropboxAppKey = "xe7v9wha7jrmii7"
    var dropBoxUser: DropboxClient? {
        return DropboxClientsManager.authorizedClient
    }
    
    //MARK: - Public Methods
    
    func setup() {
        DropboxClientsManager.setupWithAppKey(dropboxAppKey)
    }
    
    func handleRedirectURL(url: URL, appCoordinator: AppCoordinator?) {
        guard let authResult = DropboxClientsManager.handleRedirectURL(url) else {
            return
        }
        switch authResult {
            case .success:
                appCoordinator?.start()
            case .cancel:
                print("Authorization flow was manually canceled by user!")
            case .error(_, let description):
                print("Error: \(description)")
        }
    }
    
    func authorizeDropbox(from vc: UIViewController) {
        DropboxClientsManager.authorizeFromController(UIApplication.shared,
                                                      controller: vc,
                                                      openURL: { (url: URL) -> Void in
                                                        UIApplication.shared.open(url,
                                                                                  options: [:],
                                                                                  completionHandler: nil)
        })
    }
    
    func fetchFilesFromPath(path: String, completeHandler:@escaping (([DropboxEntry]?)  -> Void)) {
        dropBoxUser?.files.listFolder(path: path).response { response, error in
            guard let result = response, error == nil else {
                completeHandler(nil)
                return
            }
            
            completeHandler(result.entries.map { DropboxEntry(entry: $0) })
        }
    }
    
    func getThumbnail(with path: String, handler: @escaping ((Data?) -> Void)) {
        dropBoxUser?.files.getThumbnail(path: path).response(completionHandler: { (data, error) in
            guard error == nil,
                let responseData = data else {
                    handler(nil)
                    return
            }
            handler(responseData.1)
        })
    }
    
    func dowloadFileWith(path: String, handler: @escaping ((Data?) -> Void)) {
        dropBoxUser?.files.download(path: path).response(completionHandler: { (data, error) in
            guard error == nil,
                let responseData = data else {
                    handler(nil)
                    return
            }
            handler(responseData.1)
        })
    }
}
