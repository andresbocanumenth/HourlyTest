//
//  ImageViewerViewController.swift
//  HourlyDropBox
//
//  Created by Andres Bocanumenth on 3/05/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

import UIKit
import SnapKit

class ImageViewerViewController: UIViewController {
    
    //MARK: - UI
    
    private let imageView = UIImageView()
    private let imageName = UILabel()
    
    //MARK: - Properties
    
    private let entry: DropboxEntry
    
    //MARK: - Init
    
    init(entry: DropboxEntry) {
        self.entry = entry
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    //MARK: - Private Methods
    
    private func downloadImage() {
        guard let fileURL = entry.name.getImageDocumentPath(),
            !FileManager.default.fileExists(atPath: fileURL.path) else {
                showImage(entry.name.getImageDocumentPath())
                return
        }
        
        DropboxManager.shared.dowloadFileWith(path: entry.path ?? "") {[weak self] (data) in
            guard let data = data else {
                return
            }
            try? data.write(to: fileURL)
            self?.showImage(fileURL)
        }
    }
    
    private func showImage(_ fileURL: URL?) {
        guard let fileUrl = fileURL,
            let image = UIImage(contentsOfFile: fileUrl.path) else {
            return
        }
        imageView.image = image
    }
    
    private func configureView() {
        view.backgroundColor = .black
        title = entry.name
        configureImageView()
        configureImageName()
        downloadImage()
        imageName.text = entry.name
    }
    
    private func configureImageView() {
        view.addSubview(imageView)
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { (make) in
            make.right.left.width.equalToSuperview()
            make.height.equalTo(300)
            make.center.equalToSuperview()
        }
    }
    
    private func configureImageName() {
        view.addSubview(imageName)
        imageName.textColor = .white
        imageName.font = .boldSystemFont(ofSize: 14)
        imageName.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-15)
        }
    }
}
