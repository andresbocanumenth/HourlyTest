//
//  FilesViewController.swift
//  HourlyDropBox
//
//  Created by Andres Bocanumenth on 2/05/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

import UIKit
import SnapKit

class FilesViewController: UIViewController {

    //MARK: - UI
    
    private let tableView = UITableView()
    
    //MARK: - Properties
    
    fileprivate let cellIdentifier = "FileTableViewCell"
    private var viewModel: FilesViewModel
    
    //MARK: - Init
    
    init(viewModel: FilesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = viewModel.title
        configureView()
        configureBinding()
        viewModel.fetchData()
    }
    
    //MARK: - Private Methods
    
    private func configureBinding() {
        viewModel.filesDidLoad = {
            self.tableView.reloadData()
        }
    }
    
    private func configureView() {
        configureTableView()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FileTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.separatorColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
}

//MARK: - UITableViewDataSource

extension FilesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? FileTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        cell.updateUI(entry: viewModel.entries[indexPath.row])
        return cell
    }
}

//MARK: - UITableViewDelegate

extension FilesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.entryTapped(indexPath)        
    }
}
