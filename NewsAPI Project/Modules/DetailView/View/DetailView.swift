//
//  DetailView.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 1/2/22.
//

import UIKit

class DetailView: UIViewController {
    var viewModel: DefaultDetailViewModel?

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    private lazy var dataSource: DetailViewDataSource = {
        DetailViewDataSource(viewModel: viewModel,
                             tableView: tableView)
    }()

    private lazy var delegate: DetailViewDelegate = {
        DetailViewDelegate()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupBinding()
        configureTableView()

        viewModel?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupConstraints()
    }

    func setupNavigationBar() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = UIColor.na_magenta
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupBinding() {
        viewModel?.cells.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
    }

    func configureTableView() {
        tableView.backgroundColor = .white
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.alwaysBounceVertical = false

        dataSource.registerCells()
    }
}
