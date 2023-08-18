//
//  FightSchedulingViewController.swift
//  Wrestlers App
//
//  Created by Benjamin Jaramillo on 04/08/23.
//

import UIKit

class FightSchedulingViewController: UIViewController {
    weak var delegate: FightSchedulingDelegate?
    var wrestler: WrestlerItem?

    @IBOutlet weak var opponentImageView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Fight Scheduling"
        if let wrestler = wrestler {
            opponentImageView.image = wrestler.image
        }
    }

    @IBAction func scheduleFightButtonTapped() {
    }
}

