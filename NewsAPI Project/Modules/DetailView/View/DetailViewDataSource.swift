//
//  DetailViewDataSource.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 1/2/22.
//

import UIKit

final class DetailViewDataSource: NSObject, UITableViewDataSource {
    private var viewModel: DetailViewModel?
    private var tableView: UITableView?

    init(viewModel: DetailViewModel?,
         tableView: UITableView)
    {
        self.viewModel = viewModel
        self.tableView = tableView
    }

    func registerCells() {
        tableView?.register(cellType: TitleCell.self)
        tableView?.register(cellType: ImageCell.self)
        tableView?.register(cellType: DateCell.self)
        tableView?.register(cellType: BodyNewCell.self)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cells.value?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType = viewModel?.cells.value?[indexPath.row] else {
            return UITableViewCell()
        }

        switch cellType {
        case .titleCell(let title):
            let cell: TitleCell = tableView.dequeueReusableCell(for: indexPath)
            let model = TitleCellModel(title: title)
            cell.selectionStyle = .none
            cell.configure(model: model)
            return cell
        case .dateCell(let dateString):
            let cell: DateCell = tableView.dequeueReusableCell(for: indexPath)
            let model = DateCellModel(date: dateString)
            cell.selectionStyle = .none
            cell.configure(model: model)
            return cell
        case .imageCell(let imageURL):
            let cell: ImageCell = tableView.dequeueReusableCell(for: indexPath)
            let model = ImageCellModel(imageURL: imageURL)
            cell.selectionStyle = .none
            cell.configure(model: model)
            return cell
        case .bodyDescriptionCell(let descriptionString):
            let cell: BodyNewCell = tableView.dequeueReusableCell(for: indexPath)
            let model = BodyNewCellModel(description: descriptionString)
            cell.selectionStyle = .none
            cell.configure(model: model)
            return cell
        }
    }
}
