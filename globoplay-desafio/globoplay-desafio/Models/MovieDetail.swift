//
//  MovieDetail.swift
//  globoplay-desafio
//
//  Created by Wagner Junior  on 07/05/21.
//

import Foundation

// MARK: - Welcome
struct MovieDetail: Decodable {
    let genres: [Genre]
    let originalTitle: String
    let runtime: Int
    let releaseDate: String
    let posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case genres = "genres"
        case originalTitle = "original_title"
        case runtime
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
    
    init() {
        self.genres = [Genre]()
        self.originalTitle = ""
        self.runtime = 0
        self.releaseDate = ""
        self.posterPath = ""
    }
}

struct Genre: Decodable {
    let id: Int
    let name: String
    
    init() {
        self.id = 0
        self.name  = ""
    }
}
