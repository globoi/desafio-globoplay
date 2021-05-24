//
//  HomeViewController.swift
//  globoplay-desafio
//
//  Created by Wagner Junior  on 01/05/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK:- Properties
    let viewModel = HomeViewModel()
    let movieSections = ["Populares","Mais Vistos","Próximos Lançamentos"]
    var selectedMovie = Movie()
    
    
    //MARK:- IBOutlets
    @IBOutlet var moviesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
        
        viewModel.viewDelegate = self
        
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.register(UINib(nibName: "HomeMovieTableViewCell", bundle: nil), forCellReuseIdentifier: "movieCell")
    }
    
    fileprivate func loadMovies() {
        viewModel.loadPopularMovies()
        viewModel.loadMoviesUpcoming()
        viewModel.loadMoviesTopRated()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetailFromHome" {
            let detailMovie = segue.destination as! MovieDetailViewController
            detailMovie.detailMovie = selectedMovie
        }
    }

}

//MARK:- Extension UITableViewDelegate DataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieSections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? HomeMovieTableViewCell {
                cell.setup(sectionTitle: self.movieSections[indexPath.row], sectionMovies: viewModel.getMoviesPopular(),tableIndex: indexPath.row)
                cell.viewDelegate = self
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? HomeMovieTableViewCell {
                cell.setup(sectionTitle: self.movieSections[indexPath.row], sectionMovies: viewModel.getMoviesTopRated(),tableIndex: indexPath.row)
                cell.viewDelegate = self
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? HomeMovieTableViewCell {
                cell.setup(sectionTitle: self.movieSections[indexPath.row], sectionMovies: viewModel.getMoviesUpcoming(),tableIndex: indexPath.row)
                cell.viewDelegate = self
                return cell
            }
        default:
            break
        }
        
        return UITableViewCell()
    }
}


extension HomeViewController: HomeViewModelDelegate {
    fileprivate func reloadTableRow(withIndex indexPath: IndexPath) {
        moviesTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func moviesPopularDidChange() {
        let indexPath = IndexPath(row: 0, section: 0)
        reloadTableRow(withIndex: indexPath)
    }
    
    func moviesTopRatedDidChange() {
        let indexPath = IndexPath(row: 1, section: 0)
        reloadTableRow(withIndex: indexPath)
    }
    
    func moviesUpcomingDidChange() {
        let indexPath = IndexPath(row: 2, section: 0)
        reloadTableRow(withIndex: indexPath)
    }
    
    func fetchDidFailed() {
        print("Erro")
    }
    
    
}

extension HomeViewController: HomeViewMovieDelegate {
    func movieSelected(withMovie movie: Movie) {
        selectedMovie = movie
        self.performSegue(withIdentifier: "segueDetailFromHome", sender: self)
    }
}
