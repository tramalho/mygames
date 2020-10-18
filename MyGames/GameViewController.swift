//
//  GameViewController.swift
//  MyGames
//
//  Created by Thiago Antonio Ramalho on 09/09/20.
//  Copyright © 2020 Tramalho. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var platform: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var cover: UIImageView!
    var game: Game? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setup()
    }
    
    private func setup() {
        
        if let game = game {
            name.text = game.name
            platform.text = game.platform?.name
            
            if let releaseDate = game.releaseDate {
                let formatter = DateFormatter()
                formatter.dateStyle = .long
                self.releaseDate.text = "Data de Lançamento: \(formatter.string(from: releaseDate))"
            }
            
            if let image = game.cover as? UIImage {
                cover.image = image
            } else {
                cover.image = UIImage(named: "noCoverFull")
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? GameAddEditViewController else { return }
        vc.game = game
    }
}
