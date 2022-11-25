//
//  AnimeRepository.swift
//  AppAnimeiOS
//
//  Created by Juan Diego Marin on 22/11/22.
//

import Foundation
import UIKit
import CoreData


protocol AnimeRepositoryProtocol {
    func getAnime(completionHandler: @escaping (Result<[DataInfo], Error>) -> Void)
    func getTopAnime(completionHandler: @escaping (Result<[DataInfo], Error>) -> Void)
    func showAnime(completionHandler: @escaping (Result<[DataInfo], Error>) -> Void)
}

class AnimeRepository: AnimeRepositoryProtocol {
    
    func getTopAnime(completionHandler: @escaping (Result<[DataInfo], Error>) -> Void) {
        let url = URL(string: "https://api.jikan.moe/v4/top/anime")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            if let data = data {
                do {
                    let animes = try JSONDecoder().decode(AnimeInfo.self, from: data)
                         DispatchQueue.main.async {
                             completionHandler(.success(animes.data ?? []))
                         }
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                print("Error")
            }
        })
        task.resume()
    }
    
    func getAnime(completionHandler: @escaping (Result<[DataInfo], Error>) -> Void) {
        
        let localAnimes = self.getAnimes()
        if localAnimes.count > 0  {
            completionHandler(.success(localAnimes))
            return
        }
        
        let url = URL(string: "https://api.jikan.moe/v4/anime")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            if let data = data {
                do {
                    let animes = try JSONDecoder().decode(AnimeInfo.self, from: data)
                         DispatchQueue.main.async {
                             self.deleteAnime()
                             self.saveAnime(animes)
                             completionHandler(.success(animes.data ?? []))
                         }
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                print("Error")
            }
        })
        task.resume()
    }
    
    func showAnime(completionHandler: @escaping (Result<[DataInfo], Error>) -> Void) {
        
        let localAnimes = self.getAnimes()
        if localAnimes.count > 0  {
            completionHandler(.success(localAnimes))
            return
        }
        
        let url = URL(string: "https://api.jikan.moe/v4/anime")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            if let data = data {
                do {
                    let animes = try JSONDecoder().decode(AnimeInfo.self, from: data)
                         DispatchQueue.main.async {
                             self.deleteAnime()
                             self.saveAnime(animes)
                             completionHandler(.success(animes.data ?? []))
                         }
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                print("Error")
            }
        })
        task.resume()
    }
    
    func saveAnime(_ animes: AnimeInfo) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        animes.data?.forEach { anime in
            let animesCoreData = DataCD(context: appDelegate.persistentContainer.viewContext)
            animesCoreData.image = anime.images?.jpg?.image_url
            animesCoreData.tittle = anime.title
            animesCoreData.episodes = Int64(anime.episodes ?? 0)
            animesCoreData.rating = anime.rating
            animesCoreData.score = Double(anime.score!)
            animesCoreData.type = anime.type
            animesCoreData.duration = anime.duration
            animesCoreData.synopsis = anime.synopsis
            appDelegate.saveContext()
        }
    }
    
    private func getAnimes() -> [DataInfo] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        var animeInfo: [DataInfo] = []
        do {
            let fetchRequest: NSFetchRequest<DataCD> = DataCD.fetchRequest()
            let coreDataAnimes = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            coreDataAnimes.forEach {
                let dataCD = DataInfo(images: Image(jpg: Jpg(image_url: $0.image)),
                                      title: $0.tittle,
                                      episodes: Int($0.episodes),
                                      status: $0.status,
                                      rating: $0.rating,
                                      score: $0.score,
                                      type: $0.type,
                                      duration: $0.duration,
                                      synopsis: $0.synopsis)
                animeInfo.append(dataCD)
            }
        } catch {
            print(error.localizedDescription)
        }
        return animeInfo
    }
    
    private func deleteAnime() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        do {
            let fetchRequest: NSFetchRequest<DataCD> = DataCD.fetchRequest()
            let coreDataAnimes = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            
            coreDataAnimes.forEach {
                appDelegate.persistentContainer.viewContext.delete($0)
            }
            try appDelegate.persistentContainer.viewContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
