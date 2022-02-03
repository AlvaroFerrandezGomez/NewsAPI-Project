//
//  HomeViewDataSource.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 1/2/22.
//

import UIKit

final class HomeViewDataSource: NSObject, UITableViewDataSource {
    private var viewModel: HomeViewModel?
    private var tableView: UITableView?

    init(viewModel: HomeViewModel?,
         tableView: UITableView)
    {
        self.viewModel = viewModel
        self.tableView = tableView
    }

    func registerCells() {
        tableView?.register(cellType: ShimmerCell.self)
        tableView?.register(cellType: MainNewCell.self)
        tableView?.register(cellType: EmptyCell.self)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cells.value?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType = viewModel?.cells.value?[indexPath.row] else {
            return UITableViewCell()
        }

        switch cellType {
        case .shimmer:
            let cell: ShimmerCell = tableView.dequeueReusableCell(for: indexPath)
            cell.selectionStyle = .none
            cell.shimmerShinnig()
            cell.configure()
            return cell
        case .newCell(let id, let imageURL, let date, let title, let description):
            let cell: MainNewCell = tableView.dequeueReusableCell(for: indexPath)
            let model = MainNewCellModel(id: id, imageURL: imageURL, date: date, title: title, description: description)
            cell.selectionStyle = .none
            cell.configure(model: model)
            return cell
        case .emptyCell(let title):
            let cell: EmptyCell = tableView.dequeueReusableCell(for: indexPath)
            let model = EmptyCellModel(title: title)
            cell.selectionStyle = .none
            cell.configure(model: model)
            return cell
        }
    }
}
