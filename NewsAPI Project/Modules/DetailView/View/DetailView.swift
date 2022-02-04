//
//  DetailView.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 1/2/22.
//

import UIKit

// MARK: - Constants

extension DetailView {
    private enum Constants {
        static let backGroundColor = UIColor.white
        static let navBarTintColor = UIColor.na_magenta
        static let bayStyleColor = UIBarStyle.black
    }
}

// MARK: - DetailView

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

    // MARK: - Lifecycle methods

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

    // MARK: - Setup view method

    func setupView() {
        view.backgroundColor = Constants.backGroundColor
        view.addSubview(tableView)
        setupConstraints()
    }

    func configureTableView() {
        tableView.backgroundColor = Constants.backGroundColor
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.alwaysBounceVertical = false

        dataSource.registerCells()
    }

    // MARK: - Setup NavigationBar method

    func setupNavigationBar() {
        navigationController?.navigationBar.barStyle = Constants.bayStyleColor
        navigationController?.navigationBar.tintColor = Constants.navBarTintColor
    }

    // MARK: - Binding method

    func setupBinding() {
        viewModel?.cells.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
    }

    // MARK: - Constraints

    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
