//
//  DetailAnimeViewController.swift
//  AppAnimeiOS
//
//  Created by Juan Diego Marin on 24/11/22.
//

import UIKit

class DetailAnimeViewController: UIViewController {
    
    @IBOutlet weak var showTitleAnimeLabel: UILabel!
    @IBOutlet weak var showImageAnimeLabel: UIImageView!
    @IBOutlet weak var showRatingAnimeLabel: UILabel!
    
    @IBOutlet weak var scoreAnimeLabel: UILabel!
    
    @IBOutlet weak var showDurationAnimeLabel: UILabel!
    @IBOutlet weak var showSynopsisAnimeLabel: UILabel!
    
    // MARK: - Properties
    var showAnime: DataInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        showTitleAnimeLabel.text = showAnime?.title
        showRatingAnimeLabel.text = showAnime?.rating
        showDurationAnimeLabel.text = showAnime?.duration
        showSynopsisAnimeLabel.text = showAnime?.synopsis
        scoreAnimeLabel.text = String("\(showAnime?.score ?? 0) (Score)")
        
        if let ulrSesson = showAnime?.images?.jpg?.image_url {
            showImageAnimeLabel?.downloaded(from: ulrSesson, placeHolder: nil)
        }
    }
}
