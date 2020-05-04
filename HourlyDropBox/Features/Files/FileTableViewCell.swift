//
//  FileTableViewCell.swift
//  HourlyDropBox
//
//  Created by Andres Bocanumenth on 2/05/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

import UIKit

class FileTableViewCell: UITableViewCell {

    //MARK: - UI
    
    private let thumbnail = UIImageView()
    private let nameLabel = UILabel()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    //MARK: - Public Methods
    
    func updateUI(entry: DropboxEntry) {
        nameLabel.text = entry.name
        guard let path = entry.path else {
            return
        }
        thumbnail.image = nil
        DropboxManager.shared.getThumbnail(with: path) { (data) in
            guard let data = data,
                let image = UIImage(data: data) else {
                    self.thumbnail.image = entry.fileType.icon
                return
            }
            self.thumbnail.image = image    
        }
    }
    
    //MARK: - Private Methods
    
    private func configureView() {
        selectionStyle = .none
        backgroundColor = .lightGray
        configureImageView()
        configureFileName()
    }
    
    private func configureImageView() {
        addSubview(thumbnail)
        thumbnail.clipsToBounds = true
        thumbnail.backgroundColor = .thumbnailColor
        thumbnail.contentMode = .scaleAspectFit
        thumbnail.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(80)
        }
    }
    
    private func configureFileName() {
        addSubview(nameLabel)
        nameLabel.textColor = .black
        nameLabel.font = .boldSystemFont(ofSize: 14)
        nameLabel.numberOfLines = 1
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(thumbnail.snp.right).offset(15)
            make.top.equalToSuperview().offset(15)
            make.right.bottom.equalToSuperview().offset(-15)
            make.height.equalTo(30)
        }
    }    
}
