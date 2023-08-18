//
//  WrestlerDetailsViewController.swift
//  Wrestlers App
//
//  Created by Benjamin Jaramillo on 15/07/23.
//
import UIKit

class WrestlerDetailsViewController: UIViewController {
    var wrestler: WrestlerItem?
    
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
    
    @IBAction func UpcomingFight(){
    performSegue(withIdentifier: "showUpcomingFights", sender: self)
    }
    
  }
    
    
    



