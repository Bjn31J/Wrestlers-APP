//
//  WrestlerDetailsViewController.swift
//  Wrestlers App
//
//  Created by Benjamin Jaramillo on 15/07/23.
//
import UIKit

class WrestlerDetailsViewController: UIViewController ,UpcomingFightsViewControllerDelegate {
    var wrestler: WrestlerItem?
    var dataModel : DataModel!

    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var fightsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    private func configureUI() {
        if let wrestler = wrestler {
            title = wrestler.name
            
            descriptionLabel.text = wrestler.wrestlerDescription
            imageView.image = UIImage(named: wrestler.imageName)
            
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUpcomingFights" {
            if let upcomingFightsViewController = segue.destination as? UpcomingFightsViewController {
                upcomingFightsViewController.delegate = self
                upcomingFightsViewController.wrestlers = wrestler
            }
        }
        
    }
    
    func upcomingFightsViewController(_ controller: UpcomingFightsViewController, didAddFight fight: FightItem) {
        if let wrestler = wrestler {
                   wrestler.addFight(fight)
                   dataModel?.saveWrestlers()
        }
    }
    
    
    @IBAction func UpcomingFight(){
    performSegue(withIdentifier: "showUpcomingFights", sender: self)
    }
    
  }
    
    
    



