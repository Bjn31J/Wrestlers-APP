//
//  UpcomingFightsViewController.swift
//  Wrestlers App
//
//  Created by Benjamin Jaramillo on 26/07/23.
//

import UIKit

class UpcomingFightsViewController: UITableViewController, FightOverviewViewControllerDelegate {
    var fights = [FightItem]()
    var wrestlers: WrestlerItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true

        let fight1 = FightItem(opponent: WrestlerItem(name: "Kemonito", imageName: "kemonito", description: "Kemonito es lo bonito"), date: Date(), local: WrestlerItem(name: "La Parka", imageName:  "laparka" , description: "El mejor de México"))

        fights.append(fight1)

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FightItem")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fights.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FightItem", for: indexPath)
        let item = fights[indexPath.row]
        configureText(for: cell, with: item)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFight = fights[indexPath.row]
        performSegue(withIdentifier: "showFightOverview", sender: selectedFight)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFightOverview" {
            if let selectedFight = sender as? FightItem,
               let fightOverviewViewController = segue.destination as? FightOverviewViewController {
                fightOverviewViewController.fight = selectedFight
                fightOverviewViewController.delegate = self
            }
        } else if segue.identifier == "AddFight" {
            if let fightOverviewViewController = segue.destination as? FightOverviewViewController {
                if let wrestler = wrestlers {
                    let localWrestler = WrestlerItem(
                        name: wrestler.name,
                        imageName: wrestler.imageName,
                        description: wrestler.wrestlerDescription
                    )
                    let newFight = FightItem(opponent: nil, date: Date(), local: localWrestler)
                    fightOverviewViewController.fight = newFight
                    fightOverviewViewController.delegate = self
                }
            }
        }
    }

    @IBAction func addFightButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddFight", sender: self)
      }


    func fightDetailViewControllerDidCancel(_ controller: FightOverviewViewController) {
        navigationController?.popViewController(animated: true)
    }

    func fightDetailViewController(_ controller: FightOverviewViewController, didFinishAdding item: FightItem) {
        let newRowIndex = fights.count
        fights.append(item)

        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }

    func configureText(for cell: UITableViewCell, with item: FightItem) {
        if let opponentName = item.opponent?.name {
            cell.textLabel?.text = "\(opponentName) vs \(item.local.name)"
        }
    }
}
