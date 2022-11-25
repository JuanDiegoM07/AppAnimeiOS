//
//  ViewController.swift
//  AppAnimeiOS
//
//  Created by Juan Diego Marin on 22/11/22.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOulets
    
    @IBOutlet weak var animeTopColectionView: UICollectionView!
    @IBOutlet weak var animeColectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Private Properties
    
    private var viewModel = AnimeViewModel(repository: AnimeRepository())
        
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        configureCollectionsView()
        getAnimes()
    }
    
    
    private func configureCollectionsView() {
        animeTopColectionView.register(.init(nibName: "AnimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        animeColectionView.register(.init(nibName: "SessionLaterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "sessionCell")
        
        
        animeTopColectionView.delegate = self
        animeTopColectionView.dataSource = self
        
        animeColectionView.delegate = self
        animeColectionView.dataSource = self
    }
    
    private func getAnimes() {
        activityIndicator.startAnimating()
        viewModel.getTopAnime()
        viewModel.getAnime()
        viewModel.success = { [weak self] in
            guard let self = self else { return }
            if !self.viewModel.topAnimes.isEmpty,
               !self.viewModel.animes.isEmpty {
                self.activityIndicator.stopAnimating()
            }
            self.animeTopColectionView.reloadData()
            self.animeColectionView.reloadData()
        }
        viewModel.error = { [weak self] error in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            let alertView = UIAlertController(title: "", message: error, preferredStyle: .alert)
            alertView.addAction(.init(title: "Ok", style: .default))
            alertView.addAction(.init(title: "Reintentar", style: .default, handler: { _ in 
                self.activityIndicator.startAnimating()
                self.viewModel.getTopAnime()
                self.viewModel.getAnime()
            }))
            self.present(alertView, animated: true)
        }
    }

}

//MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == animeTopColectionView {
            return viewModel.topAnimes.count
        } else if collectionView == animeColectionView  {
            return viewModel.animes.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == animeTopColectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AnimeCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.animes = viewModel.topAnimes[indexPath.row]
            return cell
        } else if collectionView == animeColectionView {
             guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sessionCell", for: indexPath) as? SessionLaterCollectionView else {
                 return UICollectionViewCell()
             }
            cell.animesLater = viewModel.animes[indexPath.row]
             return cell
         }
        return UICollectionViewCell()
    }
}

//MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == animeTopColectionView {
            return CGSize(width: UIScreen.main.bounds.width / 2.5
                          , height: view.bounds.height / 4)
        } else if collectionView == animeColectionView {
            return CGSize(width: UIScreen.main.bounds.width, height: view.bounds.height / 4)
        } else {
        }
        return CGSize(width: UIScreen.main.bounds.width, height: view.bounds.height / 4)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    
        if collectionView == animeTopColectionView {
            let vc = DetailAnimeViewController()
            vc.showAnime = viewModel.topAnimes[indexPath.row]
            show(vc, sender: nil)
        } else if collectionView == animeColectionView  {
            let vc = DetailAnimeViewController()
            vc.showAnime = viewModel.animes[indexPath.row]
            show(vc, sender: nil)
        }
    }
}
