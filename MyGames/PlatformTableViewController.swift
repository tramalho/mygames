//
//  PlatformTableViewController.swift
//  MyGames
//
//  Created by Thiago Antonio Ramalho on 09/09/20.
//  Copyright © 2020 Tramalho. All rights reserved.
//

import UIKit

class PlatformTableViewController: UITableViewController {

    private let platformManager = PlatformManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
    }
    
    private func load() {
        platformManager.load(with: context)
        tableView.reloadData()
    }
    
    @IBAction func addPlatform(_ sender: UIBarButtonItem) {
        showAlert(platform: nil)
    }

    func showAlert(platform:Platform?) {
        
        let title = platform == nil ? "Cadastrar Plataforma" : "Editar \(platform?.name ?? "")"
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.view.tintColor = UIColor(named: "secondary")
        
        alert.addTextField { (textField) in
            textField.placeholder = "Nome da Plataforma"
            
            if let name = platform?.name {
                textField.text = name
            }
        }
        
        alert.addAction(UIAlertAction(title: "salvar", style: .default, handler: { (action) in
            let editedPlatform = platform ?? Platform(context: self.context)
            editedPlatform.name = alert.textFields?.first?.text
            
            do {
                try self.context.save()
                self.load()
            } catch {
                print(error.localizedDescription)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "cancelar", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)

    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return platformManager.platforms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let platform = platformManager.platforms[indexPath.row]
        cell.textLabel?.text = platform.name
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let platform = PlatformManager.shared.platforms[indexPath.row]
        showAlert(platform: platform)
        tableView.reloadData()
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            platformManager.delete(with: context, idx: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
