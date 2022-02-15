//
//  SimulateViewController.swift
//  IPL
//
//  Created by Jithin on 16/02/22.
//

import UIKit

class SimulateViewController: UIViewController {

    @IBOutlet weak var simulateButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        simulateButton.layer.cornerRadius = 20
        simulateButton.titleEdgeInsets = UIEdgeInsets(top: 0,left: 10,bottom: 0,right: 10)
        setNavBar()

    }
    func setNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor.systemBlue
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    

    
    @IBAction func simulateTapped(_ sender: Any) {
    }
    
}
