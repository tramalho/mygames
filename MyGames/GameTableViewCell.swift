//
//  GameTableViewCell.swift
//  MyGames
//
//  Created by Thiago Antonio Ramalho on 09/09/20.
//  Copyright © 2020 Tramalho. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var platform: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func prepare(with game: Game) {
        name?.text = game.name ?? ""
        platform?.text = game.platform?.name ?? ""
        
        if let image = game.cover as? UIImage {
            cover.image = image
        } else {
            cover.image = UIImage(named: "noCover")
        }
    }
}
