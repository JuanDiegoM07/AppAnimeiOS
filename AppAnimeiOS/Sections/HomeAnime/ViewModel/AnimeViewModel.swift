//
//  AnimeViewModel.swift
//  AppAnimeiOS
//
//  Created by Juan Diego Marin on 23/11/22.
//

import Foundation

class AnimeViewModel {
    
    // MARK: - Internal Properties
    
    var error: (String) -> Void = { _ in }
    var success: () -> Void = {}
    var animes: [DataInfo] = []
    var topAnimes: [DataInfo] = []
    var showAnime: [DataInfo] = []
    
    // MARK: - Private Properties
    
    private var repository: AnimeRepositoryProtocol!
    
    init(repository: AnimeRepositoryProtocol) {
        self.repository = repository
    }
    
    func getTopAnime() {
        repository.getTopAnime { result in
            switch result {
            case .success(let animes):
                self.topAnimes = animes
                self.success()
            case .failure(let error):
                self.error(error.localizedDescription)
            }
        }
    }
    
    func getAnime() {
        repository.getAnime { result in
            switch result {
            case .success(let animes):
                self.animes = animes
                self.success()
            case .failure(let error):
                self.error(error.localizedDescription)
            }
        }
    }
    
    func showAnimes() {
        repository.showAnime { result in
            switch result {
            case .success(let animes):
                self.showAnime = animes
                self.success()
            case .failure(let error):
                self.error(error.localizedDescription)
            }
        }
    }

}
