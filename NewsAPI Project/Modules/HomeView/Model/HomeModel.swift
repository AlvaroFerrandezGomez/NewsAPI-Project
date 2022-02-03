//
//  HomeModel.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 1/2/22.
//

import Foundation

struct HomeModel {
    var news: [NewPresentationModel]
}

struct NewPresentationModel {
    var id: String
    var title: String
    var description: String
    var imageURL: String
    var date: String
}
