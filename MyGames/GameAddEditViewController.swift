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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func addNewCover(_ sender: UIButton) {
    }
    
    @IBAction func save(_ sender: UIButton) {
    }
}
