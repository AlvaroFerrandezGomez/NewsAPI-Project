//
//  HomeView.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 1/2/22.
//

import UIKit

// MARK: - Constants

extension HomeView {
    private enum Colours {
        static let backGroundColor = UIColor.white
        static let navBarTintColor = UIColor.na_magenta
        static let bayStyleColor = UIColor.black
        static let barTintColor = UIColor.na_magenta
    }

    private enum Images {
        static let searchImage = UIImage(systemName: "magnifyingglass")
        static let sortImageDown = UIImage(systemName: "chevron.down.circle")
        static let sortImageUp = UIImage(systemName: "chevron.up.circle")
    }

    private enum Strings {
        static let title = "News"
        static let errorTitle = "Error"
        static let errorDescription = "Ha ocurrido un error"
        static let errorOK = "Ok"
        static let placeholderString = "Escriba algo para buscar..."
        static let emptyString = ""
    }

    private enum Constraints {
        static let searchBarTop = 94.0
        static let searchBarHeight = 60.0
    }
}

// MARK: - HomeView

class HomeView: UIViewController, UISearchBarDelegate {
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

    // MARK: - Lifecycle methods

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

    // MARK: - Setup view method

    func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupConstraints()
    }

    func configureTableView() {
        tableView.backgroundColor = Colours.backGroundColor
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.alwaysBounceVertical = false

        dataSource.registerCells()
    }

    // MARK: - Setup navigationBar methods

    func setupTitleNavBar() {
        navigationItem.title = Strings.title

        let textAttributes = [NSAttributedString.Key.foregroundColor: Colours.barTintColor]

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Colours.backGroundColor
        appearance.titleTextAttributes = textAttributes
        navigationController?.navigationBar.standardAppearance = appearance
    }

    func setupNavigationBar() {
        let searchButton = UIBarButtonItem(image: Images.searchImage, style: .plain, target: self, action: #selector(searchButtonTappedHandler))
        let sortButton = UIBarButtonItem(image: (viewModel?.upwardSorted.value ?? false) ? Images.sortImageUp : Images.sortImageDown, style: .plain, target: self, action: #selector(sortedButtonTappedHandler))

        searchButton.tintColor = Colours.barTintColor
        sortButton.tintColor = Colours.barTintColor

        navigationItem.rightBarButtonItems = [searchButton, sortButton]
    }

    // MARK: - NavigationBar methods

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

    // MARK: - Navigation to detail method

    func goToDetail(id: String) {
        if let newSelected = viewModel?.model?.news.first(where: { $0.id == id }) {
            let viewController = DetailServiceLocator.provideViewController(newSelected: newSelected)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

    // MARK: - SearchBar methods

    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = Strings.placeholderString
        searchBar.showsCancelButton = true

        searchBar.tintColor = Colours.barTintColor
        searchBar.searchTextField.textColor = Colours.barTintColor
        searchBar.searchTextField.backgroundColor = Colours.barTintColor.withAlphaComponent(0.1)
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

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.filterNews(searchText: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = Strings.emptyString
        viewModel?.filterNews(searchText: Strings.emptyString)
        viewModel?.searchBarVisible.value = false
    }

    // MARK: - Binding method

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

    // MARK: - Error method

    func showError() {
        let alertView = UIAlertController(title: Strings.errorTitle, message: Strings.errorDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Strings.errorOK, style: .default, handler: { _ in self.viewModel?.retryButton() })
        alertView.addAction(okAction)
        present(alertView, animated: true, completion: nil)
    }

    // MARK: - Constraints

    func setupConstraints() {
        if viewModel?.searchBarVisible.value ?? false {
            NSLayoutConstraint.activate([
                searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: Constraints.searchBarTop),
                searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                searchBar.heightAnchor.constraint(equalToConstant: Constraints.searchBarHeight),
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
}
