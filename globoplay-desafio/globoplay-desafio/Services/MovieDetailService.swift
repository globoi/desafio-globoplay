//
//  MovieDetailService.swift
//  globoplay-desafio
//
//  Created by Wagner Junior  on 07/05/21.
//

import Foundation

class MovieDetailService: ServiceBase {
    func fetch(path: MovieCategory, movieId: String, completionHandler: @escaping (Result<MovieDetail, FetchError>) -> Void) {
        
        fetch(listOf: MovieDetail.self, withURL: url(withPath: path.rawValue + "/" + movieId)  ) { (result) in
            switch result {
            case .success(let movieDetail):
                completionHandler(Result.success(movieDetail))
            case .failure(let error):
                completionHandler(Result.failure(error))
            }
        }
        
    }
}
