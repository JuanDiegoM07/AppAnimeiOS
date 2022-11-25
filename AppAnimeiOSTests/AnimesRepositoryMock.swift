//
//  AnimesRepositoryMock.swift
//  AppAnimeiOSTests
//
//  Created by Juan Diego Marin on 24/11/22.
//

import Foundation
@testable import AppAnimeiOS

class AnimesRepositoryMock: AnimeRepositoryProtocol {
    
    func showAnime(completionHandler: @escaping (Result<[DataInfo], Error>) -> Void) {
        if let animes = animes {
            completionHandler(.success(animes))
        }
    }
    
    var animes: [DataInfo]?
    
    func getTopAnime(completionHandler: @escaping (Result<[DataInfo], Error>) -> Void) {
        if let animes = animes {
            completionHandler(.success(animes))
        }
    }
    
    func getAnime(completionHandler: @escaping (Result<[DataInfo], Error>) -> Void) {
        if let animes = animes {
            completionHandler(.success(animes))
        }
    }
}
