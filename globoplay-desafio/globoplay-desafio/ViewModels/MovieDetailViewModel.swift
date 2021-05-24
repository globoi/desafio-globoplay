//
//  MovieDetailViewModel.swift
//  globoplay-desafio
//
//  Created by Wagner Junior  on 07/05/21.
//

import Foundation

protocol MovieDetailDelegate: class {
    func detailMovieLoaded()
    func fetchDidFailed()
}

class MovieDetailViewModel {
    
    let movieDetailsService = MovieDetailService()
    weak var viewDelegate: MovieDetailDelegate?
    var movieDetail = MovieDetail(){
        didSet {
            viewDelegate?.detailMovieLoaded()
        }
    }
    
    func loadMovieDetails(movieDetail: Movie) {
        movieDetailsService.fetch(path: .details, movieId: String(movieDetail.id)) { (result) in
            switch result {
            case .success(let movieDetail):
                self.movieDetail = movieDetail
            case .failure:
                self.viewDelegate?.fetchDidFailed()
            }
        }
    }
    
    func movieDetailsData() -> MovieDetail {
        return movieDetail
    }
}
