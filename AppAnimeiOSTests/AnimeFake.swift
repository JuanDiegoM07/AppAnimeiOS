//
//  AnimeFake.swift
//  AppAnimeiOSTests
//
//  Created by Juan Diego Marin on 24/11/22.
//

import Foundation
@testable import AppAnimeiOS

enum AnimeFake {
    
    static var values: [AnimeInfo] {
        [.init(data: dataInfo)]
    }
    
    static var dataInfo: [DataInfo] {
        [.init(images: Image.init(jpg: .init(image_url: "")),
               title: "",
               episodes: 0,
               status: "",
               rating: "",
               score: 0.0,
               type: "",
               duration: "",
               synopsis: ""
               )]
    }
}
