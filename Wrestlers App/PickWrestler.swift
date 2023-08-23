//
//  PickWrestler.swift
//  Wrestlers App
//
//  Created by Benjamin Jaramillo on 10/08/23.
//

import UIKit

protocol PickWrestlerViewControllerDelegate: AnyObject {
    func iconPicker(_ picker: PickWrestler, didPick wrestler: WrestlerItem)
}

class PickWrestler: UITableViewController {
    var wrestlers = [WrestlerItem]()
    weak var delegate: PickWrestlerViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true

        let wrestler1 = WrestlerItem(name: "La Parka", imageName: "laparka", description: "El mejor de México",fights: [FightItem]())
        wrestlers.append(wrestler1)

        let wrestler2 = WrestlerItem(name: "Kemonito", imageName: "kemonito", description: "Kemonito es lo bonito",fights: [FightItem]())
        wrestlers.append(wrestler2)
        
        let wrestler3 = WrestlerItem(name: "Alushe", imageName: "alushe", description: "Creatura mitica Mexicana",fights: [FightItem]())
        wrestlers.append(wrestler3)
               
        let wrestler4 = WrestlerItem(name: "Octagon Jr", imageName: "octagon", description: "El oriental mas Mexiccano",fights: [FightItem]())
        wrestlers.append(wrestler4)
               
        let wrestler5 = WrestlerItem(name: "Super Porky", imageName: "superporky", description: "Debe sudar chesco",fights: [FightItem]())
        wrestlers.append(wrestler5)
               
        let wrestler6 = WrestlerItem(name: "Chessman", imageName: "chessman", description: "Disipulo del devil",fights: [FightItem]())
        wrestlers.append(wrestler6)
    

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "WrestlerItem")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wrestlers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WrestlerItem", for: indexPath)
        let wrestler = wrestlers[indexPath.row]
        cell.textLabel?.text = wrestler.name
        cell.imageView?.image = UIImage(named: wrestler.imageName)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedWrestler = wrestlers[indexPath.row]
        delegate?.iconPicker(self, didPick: selectedWrestler)
    }
}


