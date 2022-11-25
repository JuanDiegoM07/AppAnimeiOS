//
//  Anime.swift
//  AppAnimeiOS
//
//  Created by Juan Diego Marin on 22/11/22.
//

import Foundation
import UIKit


struct AnimeInfo: Decodable {
    let data: [DataInfo]?
    
    init(data: [DataInfo]?) {
        self.data = data
    }
}

struct DataInfo: Decodable {
    let images: Image?
    let title: String?
    let episodes: Int?
    let status: String?
    let rating: String?
    let score: Double?
    let type: String?
    let duration: String?
    let synopsis: String?
    
    init(images: Image?, title: String?, episodes: Int?, status: String?, rating: String?, score: Double?, type: String?, duration: String?, synopsis: String?) {
        self.images = images
        self.title = title
        self.episodes = episodes
        self.status = status
        self.rating = rating
        self.score = score
        self.type = type
        self.duration = duration
        self.synopsis = synopsis
    }
}

struct Image: Decodable {
    let jpg: Jpg?
}

struct Jpg: Decodable {
    let image_url: String?
}

