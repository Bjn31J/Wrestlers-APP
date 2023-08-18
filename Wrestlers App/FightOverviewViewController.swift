//
//  FightsDetailsViewController.swift
//  Wrestlers App
//
//  Created by Benjamin Jaramillo on 26/07/23.
//

import UIKit
import UserNotifications

protocol FightOverviewViewControllerDelegate: AnyObject {
    func fightDetailViewControllerDidCancel(_ controller: FightOverviewViewController)
    func fightDetailViewController(_ controller: FightOverviewViewController, didFinishAdding item: FightItem)
}

class FightOverviewViewController: UIViewController, PickWrestlerViewControllerDelegate {
    var fight: FightItem?
    weak var delegate: FightOverviewViewControllerDelegate?

    @IBOutlet var opponentImageView: UIImageView!
    @IBOutlet var localImageView: UIImageView!
    @IBOutlet var opponentLabel: UILabel!
    @IBOutlet var localLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        if fight?.opponent == nil {
            configureUI2()
        }else{
            configureUI()
        }
        
    }

    private func configureUI() {
        if let fight = fight {
            title = "Fight Overview"
            localImageView.image = UIImage(named: fight.local.imageName)
            localLabel.text = fight.local.name
            datePicker.date = fight.date
            if let opponent = fight.opponent {
                opponentImageView.image = UIImage(named: opponent.imageName)
                opponentLabel.text = opponent.name
            }
        }
    }
    
    private func configureUI2(){
        if let fight = fight {
            title = "Add Fight"
            localImageView.image = UIImage(named: fight.local.imageName)
            localLabel.text = fight.local.name
            datePicker.date = fight.date
            fight.scheduleNotification()
            
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound]) {_, _
       in
             // do nothing
           }
            
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOpponentImageView))
                  opponentImageView.isUserInteractionEnabled = true
                  opponentImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func  didTapOpponentImageView(){
        performSegue(withIdentifier: "listWrestlers", sender: self)
        
    }
    
    // MARK: - wrestler Picker View Controller Delegate
    func iconPicker(_ picker: PickWrestler, didPick wrestler: WrestlerItem) {
        opponentImageView.image = UIImage(named: wrestler.imageName)
            opponentLabel.text = wrestler.name
            navigationController?.popViewController(animated: true)
        
              fight?.opponent = wrestler
              
              if let delegate = delegate, let fight = fight {
                  delegate.fightDetailViewController(self, didFinishAdding: fight)
              }
        }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "listWrestlers" {
                let controller = segue.destination as! PickWrestler
                controller.delegate = self
            }
    }

}




