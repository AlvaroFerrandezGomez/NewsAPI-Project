//
//  HomeView.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 1/2/22.
//

import UIKit

class HomeView: UIViewController {
    var viewModel: DefaultHomeViewModel?

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        return searchBar
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    private lazy var dataSource: HomeViewDataSource = {
        HomeViewDataSource(viewModel: viewModel,
                           tableView: tableView)
    }()

    private lazy var delegate: HomeViewDelegate = {
        HomeViewDelegate(view: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupBinding()
        configureTableView()
        setupSearchBar()

        viewModel?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTitleNavBar()
        setupNavigationBar()
    }

    func setupTitleNavBar() {
        navigationItem.title = "News"

        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.na_magenta]

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.na_white
        appearance.titleTextAttributes = textAttributes
        navigationController?.navigationBar.standardAppearance = appearance
    }

    func setupNavigationBar() {
        let searchImage = UIImage(systemName: "magnifyingglass")
        let sortImageDown = UIImage(systemName: "chevron.down.circle")
        let sortImageUp = UIImage(systemName: "chevron.up.circle")

        let searchButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(searchButtonTappedHandler))
        let sortButton = UIBarButtonItem(image: (viewModel?.upwardSorted.value ?? false) ? sortImageUp : sortImageDown, style: .plain, target: self, action: #selector(sortedButtonTappedHandler))

        searchButton.tintColor = UIColor.na_magenta
        sortButton.tintColor = UIColor.na_magenta

        navigationItem.rightBarButtonItems = [searchButton, sortButton]
    }

    @objc func searchButtonTappedHandler() {
        viewModel?.searchBarVisible.value = !(viewModel?.searchBarVisible.value ?? false)
    }

    @objc func sortedButtonTappedHandler() {
        if let searchButton = navigationItem.rightBarButtonItems?[0] {
            DispatchQueue.main.async {
                searchButton.image?.withHorizontallyFlippedOrientation()
            }
        }
        viewModel?.sortedButtonTapped()
    }

    func goToDetail(id: String) {
        if let newSelected = viewModel?.model?.news.first(where: { $0.id == id }) {
            let viewController = DetailServiceLocator.provideViewController(newSelected: newSelected)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

    func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupConstraints()
    }

    func setupConstraints() {
        if viewModel?.searchBarVisible.value ?? false {
            NSLayoutConstraint.activate([
                searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 94),
                searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                searchBar.heightAnchor.constraint(equalToConstant: 60),
                searchBar.bottomAnchor.constraint(equalTo: tableView.topAnchor),

                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }

    func setupBinding() {
        viewModel?.cells.bind { [weak self] _ in
            guard let self = self else { return }
            self.tableView.reloadData()
        }

        viewModel?.upwardSorted.bind { [weak self] _ in
            guard let self = self else { return }
            self.setupNavigationBar()
        }

        viewModel?.searchBarVisible.bind { [weak self] searchBarVisible in
            guard let self = self,
                  let searchBarVisible = searchBarVisible else { return }
            self.showSearchBar(searchBarVisible: searchBarVisible)
        }

        viewModel?.error.bind { [weak self] error in
            guard let self = self,
                  let error = error else { return }
            if error {
                self.showError()
            }
        }
    }

    func showError() {
        let alertView = UIAlertController(title: "Error", message: "Ha ocurrido un error", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in self.viewModel?.retryButton() })
        alertView.addAction(okAction)
        present(alertView, animated: true, completion: nil)
    }

    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Escriba algo para buscar..."
        searchBar.showsCancelButton = true

        searchBar.tintColor = UIColor.na_magenta
        searchBar.searchTextField.textColor = UIColor.na_magenta
        searchBar.searchTextField.backgroundColor = UIColor.na_magenta.withAlphaComponent(0.1)
    }

    func showSearchBar(searchBarVisible: Bool) {
        if searchBarVisible {
            view.addSubview(searchBar)
        } else {
            searchBar.removeFromSuperview()
        }

        view.removeAllConstraints()
        setupConstraints()
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

extension HomeView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.filterNews(searchText: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        viewModel?.filterNews(searchText: "")
        viewModel?.searchBarVisible.value = false
    }
}
