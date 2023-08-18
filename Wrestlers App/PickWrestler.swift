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

        let wrestler1 = WrestlerItem(name: "La Parka", imageName: "laparka", description: "El mejor de México")
        wrestlers.append(wrestler1)

        let wrestler2 = WrestlerItem(name: "Kemonito", imageName: "kemonito", description: "Kemonito es lo bonito")
        wrestlers.append(wrestler2)

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


