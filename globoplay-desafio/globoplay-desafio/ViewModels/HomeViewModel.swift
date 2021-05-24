//
//  HomeViewModel.swift
//  globoplay-desafio
//
//  Created by Wagner Junior  on 01/05/21.
//

import Foundation

protocol HomeViewModelDelegate: class {
    func moviesPopularDidChange()
    func moviesTopRatedDidChange()
    func moviesUpcomingDidChange()
    func fetchDidFailed()
}

class HomeViewModel {
    
    let movieService = MovieService()
    weak var viewDelegate: HomeViewModelDelegate?
    var movieResponse: MovieResponse?
    var moviesPopular: [Movie] = [Movie]() {
        didSet {
            viewDelegate?.moviesPopularDidChange()
        }
    }
    
    var moviesTopRated: [Movie] = [Movie]() {
        didSet {
            viewDelegate?.moviesTopRatedDidChange()
        }
    }
    
    var moviesUpcoming: [Movie] = [Movie]() {
        didSet {
            viewDelegate?.moviesUpcomingDidChange()
        }
    }
    
    func loadPopularMovies() {
        movieService.fetch(path: .popular) { [weak self] result in
            switch result {
            case .success(let movieResponse):
                self?.movieResponse = movieResponse
                if let movieData = self?.movieResponse {
                    self?.moviesPopular.append(contentsOf: movieData.results)
                }
            case .failure:
                self?.viewDelegate?.fetchDidFailed()
            }
        }
    }
    
    func loadMoviesTopRated() {
        movieService.fetch(path: .topRated) { [weak self] result in
            switch result {
            case .success(let movieResponse):
                self?.movieResponse = movieResponse
                if let movieData = self?.movieResponse {
                    self?.moviesTopRated.append(contentsOf: movieData.results)
                }
            case .failure:
                self?.viewDelegate?.fetchDidFailed()
            }
        }
    }
    
    func loadMoviesUpcoming() {
        movieService.fetch(path: .upcoming) { [weak self] result in
            switch result {
            case .success(let movieResponse):
                self?.movieResponse = movieResponse
                if let movieData = self?.movieResponse {
                    self?.moviesUpcoming.append(contentsOf: movieData.results)
                }
            case .failure:
                self?.viewDelegate?.fetchDidFailed()
            }
        }
    }
    
    //MARK:- Popular movies properties
    func getMoviesPopular() -> [Movie] {
        return moviesPopular
    }
    
    func numberOfPopularMovies() -> Int {
        return moviesPopular.count
    }
    
    //MARK:- Top Rated movies properties
    func getMoviesTopRated() -> [Movie] {
        return moviesTopRated
    }
    
    func numberOfTopRatedMovies() -> Int {
        return moviesTopRated.count
    }
    
    //MARK:- Upcoming movies properties
    func getMoviesUpcoming() -> [Movie] {
        return moviesUpcoming
    }
    
    func numberOfUpcomingMovies() -> Int {
        return moviesUpcoming.count
    }
}
