//
//  ViewController.swift
//  Wrestlers App
//
//  Created by Benjamin Jaramillo on 15/07/23.
//

import UIKit

class WrestlersViewController: UITableViewController {
    var dataModel : DataModel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let wrestler1 = WrestlerItem(name: "La Parka", imageName: "laparka", description: "El mejor de México",fights: [FightItem]())
        dataModel.Wrestlers.append(wrestler1)
        
        let wrestler2 = WrestlerItem(name: "Kemonito", imageName: "kemonito", description: "Kemonito es lo bonito",fights: [FightItem]())
        dataModel.Wrestlers.append(wrestler2)
        
        let wrestler3 = WrestlerItem(name: "Alushe", imageName: "alushe", description: "Creatura mitica Mexicana",fights: [FightItem]())
        dataModel.Wrestlers.append(wrestler3)
               
        let wrestler4 = WrestlerItem(name: "Octagon Jr", imageName: "octagon", description: "El oriental mas Mexicano",fights: [FightItem]())
        dataModel.Wrestlers.append(wrestler4)
               
        let wrestler5 = WrestlerItem(name: "Super Porky", imageName: "superporky", description: "Debe sudar chesco",fights: [FightItem]())
        dataModel.Wrestlers.append(wrestler5)
               
        let wrestler6 = WrestlerItem(name: "Chessman", imageName: "chessman", description: "Disipulo del devil",fights: [FightItem]())
        dataModel.Wrestlers.append(wrestler6)
    
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FightItem")
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return dataModel.Wrestlers.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath:
        IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WrestlerItem", for: indexPath)
            let item = dataModel.Wrestlers[indexPath.row]
        configureText(for: cell, with: item)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWrestler" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedWrestler = dataModel.Wrestlers[indexPath.row]
                if let wrestlerDetailsViewController = segue.destination as? WrestlerDetailsViewController {
                    wrestlerDetailsViewController.wrestler = selectedWrestler
                }
            }
        }
    }
    
    func configureText(for cell: UITableViewCell, with item: WrestlerItem) {
        cell.textLabel?.text = item.name
        cell.imageView?.image = UIImage(named: item.imageName)
    }
}

