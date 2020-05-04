//
//  PermissionRequestViewController.swift
//  HourlyDropBox
//
//  Created by Andres Bocanumenth on 1/05/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyDropbox

class PermissionRequestViewController: UIViewController {

    //Mark:- UI
    
    private let pleaseImageView = UIImageView()
    private let pleaseLabel = UILabel()
    private let connectButton = UIButton()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureView()
    }
    
    //Mark:- Actions
    
    @objc private func connectAction() {
        DropboxManager.shared.authorizeDropbox(from: self)
    }
    
    //Mark:- Private Functions
    
    private func configureView() {
        configurePleaseImageView()
        configurePleaseLabel()
        configureConnectButton()
    }
    
    private func configurePleaseImageView() {
        view.addSubview(pleaseImageView)
        pleaseImageView.contentMode = .scaleAspectFill
        pleaseImageView.image = UIImage(named: "please")
        pleaseImageView.clipsToBounds = true
        pleaseImageView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(320)
        }
    }
    
    private func configurePleaseLabel() {
        view.addSubview(pleaseLabel)
        pleaseLabel.text = "Please connect your Dropbox Account"
        pleaseLabel.textAlignment = .center
        pleaseLabel.snp.makeConstraints { (make) in
            make.top.equalTo(pleaseImageView.snp.bottom).offset(15)
            make.left.equalTo(pleaseImageView.snp.left).offset(15)
            make.right.equalTo(pleaseImageView.snp.right).offset(-15)
        }
    }
    
    private func configureConnectButton() {
        view.addSubview(connectButton)
        connectButton.setTitle("Connect With Dropbox", for: .normal)
        connectButton.layer.cornerRadius = 5
        connectButton.backgroundColor = .dropboxColor
        connectButton.addTarget(self, action: #selector(connectAction), for: .touchUpInside)
        connectButton.snp.makeConstraints { (make) in
            make.top.equalTo(pleaseLabel.snp.bottom).offset(15)
            make.left.equalTo(pleaseLabel.snp.left)
            make.right.equalTo(pleaseLabel.snp.right)
            make.height.equalTo(50)
        }
    }
}
