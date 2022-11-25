//
//  AnimeCollectionViewCell.swift
//  AppAnimeiOS
//
//  Created by Juan Diego Marin on 22/11/22.
//

import UIKit

class AnimeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutles Properties
    
    @IBOutlet weak var animeImage: UIImageView!{
        didSet {
            animeImage.layer.cornerRadius = 20
            animeImage.clipsToBounds = true
        }
    }
    
    // MARK: - Properties
    
    var animes: DataInfo? {
        didSet {
            setup()
        }
    }

    private func setup() {
        if let url = animes?.images?.jpg?.image_url {
            animeImage.downloaded(from: url, placeHolder: nil)
        }
    }

}
