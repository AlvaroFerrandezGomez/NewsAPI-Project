//
//  HomeViewDelegate.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 1/2/22.
//

import UIKit

final class HomeViewDelegate: NSObject, UITableViewDelegate {
    private var view: HomeView?

    init(view: HomeView?) {
        self.view = view
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MainNewCell {
            view?.goToDetail(id: cell.getId())
        }
    }
}
