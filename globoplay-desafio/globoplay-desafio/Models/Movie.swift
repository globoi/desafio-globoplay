//
//  Movie.swift
//  globoplay-desafio
//
//  Created by Wagner Junior  on 02/05/21.
//

import Foundation

struct MovieResponse: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    private enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
}

struct Movie: Decodable {
    let id: Int
    let original_title: String
    let overview: String
    let poster_path: String
    let title: String
    let video: Bool
    
    init() {
        self.id = 0
        self.original_title = ""
        self.overview = ""
        self.poster_path = ""
        self.title = ""
        self.video = false
    }
}
