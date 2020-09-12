//
//  GameAddEditViewController.swift
//  MyGames
//
//  Created by Thiago Antonio Ramalho on 09/09/20.
//  Copyright © 2020 Tramalho. All rights reserved.
//

import UIKit

class GameAddEditViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var platform: UITextField!
    @IBOutlet weak var releaseDate: UIDatePicker!
    @IBOutlet weak var cover: UIImageView!
    
    private var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addNewCover(_ sender: UIButton) {
    }
    
    @IBAction func save(_ sender: UIButton) {
        
        if game == nil {
            game = Game(context: context)
        }
        
        game.name = name.text
        game.releaseDate = releaseDate.date
        
        do {
            try context.save()
        } catch  {
            print(error.localizedDescription)
        }
        
        navigationController?.popViewController(animated: true)
    }
}
