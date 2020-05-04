//
//  PDFViewerViewController.swift
//  HourlyDropBox
//
//  Created by Andres Bocanumenth on 3/05/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

import UIKit
import PDFKit

class PDFViewerViewController: UIViewController {

    //MARK: - UI
    
    private let pdfViewer = PDFView()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        showDocument()
    }
    
    //MARK: - Private Methods
    
    private func configureView() {
        title = entry.name
        view.backgroundColor = .white
        view.addSubview(pdfViewer)
        pdfViewer.displayMode = .singlePageContinuous
        pdfViewer.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    private func showDocument() {
        guard let fileURL = entry.name.getImageDocumentPath(),
            !FileManager.default.fileExists(atPath: fileURL.path) else {
                createPDFDocument(entry.name.getImageDocumentPath())
                return
        }

        DropboxManager.shared.dowloadFileWith(path: entry.path ?? "") {[weak self] (data) in
            guard let data = data else {
                return
            }
            try? data.write(to: fileURL)
            self?.createPDFDocument(fileURL)
        }
    }
    
    private func createPDFDocument(_ fileURL: URL?) {
        guard let fileUrl = fileURL else {
            return
        }
        if let document = PDFDocument(url: fileUrl) {
            pdfViewer.document = document
        }
    }
}
