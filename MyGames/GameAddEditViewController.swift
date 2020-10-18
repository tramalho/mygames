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
    @IBOutlet weak var coverButton: UIButton!
    
    var game: Game!
    private var platformManager = PlatformManager.shared
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        return pickerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView()
    }
    
    private func setupPickerView() {
        pickerView.backgroundColor = .white
        let canncelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        toolbar.tintColor = UIColor(named: "primary")
        toolbar.items = [canncelButton, flexButton, doneButton]
        
        platform.inputView = pickerView
        
        platform.inputAccessoryView = toolbar
    }
    
    private func setupData() {
        if let game = game {
            name.text = game.name
            
            if let platform = game.platform, let index = platformManager.platforms.firstIndex(of: platform) {
                self.platform.text = platform.name
                pickerView.selectRow(index, inComponent: 0, animated: false)
            }
            
            if let releaseDate = game.releaseDate {
               self.releaseDate.date = releaseDate
            }
            
            if let image = game.cover as? UIImage {
                cover.image = image
            }
        }
    }
    
    @objc private func cancel() {
        platform.resignFirstResponder()
    }
    
    @objc private func done() {
        if let platform = getPlatformFromPickerView() {
            self.platform?.text = platform.name
        }
        cancel()
    }
    
    private func getPlatformFromPickerView() -> Platform? {
        return platformManager.platforms[pickerView.selectedRow(inComponent: 0)]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        platformManager.load(with: context)
        setupData()
    }
    
    @IBAction func addNewCover(_ sender: UIButton) {
        let alert = UIAlertController(title: "Selecionar Image", message: "De onde você deseja obter a imagem?", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(createActionSheet(sourceType: .camera, title: "Câmera"))
        }
        
        alert.addAction(createActionSheet(sourceType: .photoLibrary, title: "Biblioteca de Fotos"))
        alert.addAction(createActionSheet(sourceType: .savedPhotosAlbum, title: "Álbum de Fotos"))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        
        if game == nil {
            game = Game(context: context)
        }
        
        game.name = name.text
        game.releaseDate = releaseDate.date
        
        if !(platform.text?.isEmpty ?? true) {
            game.platform = getPlatformFromPickerView()
        }
        
        game.cover = cover.image
        
        do {
            try context.save()
        } catch  {
            print(error.localizedDescription)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    private func createActionSheet(sourceType: UIImagePickerController.SourceType, title: String) -> UIAlertAction {
        return UIAlertAction(title: title, style: .default, handler: { (UIAlertAction) in
            self.selectPicture(sourceType: sourceType)
        })
    }
    
    private func selectPicture(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        imagePicker.navigationBar.tintColor = UIColor(named: "primary")
        present(imagePicker, animated: true, completion: nil)
    }
}

extension GameAddEditViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return platformManager.platforms.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return platformManager.platforms[row].name
    }
}

extension GameAddEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            cover.image = image
            coverButton.setTitle(nil, for: .normal)
            dismiss(animated: true, completion: nil)
        }
    }
}
