//
//  SessionLaterCollectionView.swift
//  AppAnimeiOS
//
//  Created by Juan Diego Marin on 24/11/22.
//

import UIKit

class SessionLaterCollectionView: UICollectionViewCell {
    
    @IBOutlet weak var animeLastSessonImage: UIImageView!{
        didSet {
            animeLastSessonImage.layer.cornerRadius = 35
            animeLastSessonImage
                .clipsToBounds = true
        }
    }
    @IBOutlet weak var typeLastSessonLabel: UILabel!
    @IBOutlet weak var titleLastSessonLabel: UILabel!
    @IBOutlet weak var episodesLastSessonLabel: UILabel!
    @IBOutlet weak var durationLastSessonLabel: UILabel!
    
    // MARK: - Properties
    var animesLater: DataInfo? {
        didSet {
            setup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func setup() {
        
        if let ulrSesson = animesLater?.images?.jpg?.image_url {
            animeLastSessonImage?.downloaded(from: ulrSesson, placeHolder: nil)
        }
        
        typeLastSessonLabel?.text = animesLater?.type
    
        if animesLater?.type == "TV" {
            typeLastSessonLabel.backgroundColor = .red
            typeLastSessonLabel.layer.cornerRadius = 7
            typeLastSessonLabel.clipsToBounds = true
            
        } else {
            typeLastSessonLabel.backgroundColor = .purple
        }
        titleLastSessonLabel?.text = animesLater?.title
        episodesLastSessonLabel?.text = String("Episodes: \(animesLater?.episodes ?? 0)")
        durationLastSessonLabel?.text = animesLater?.duration
    }
    
}
