//
//  ResultViewController.swift
//  IPL
//
//  Created by Jithin on 16/02/22.
//

import UIKit

protocol MatchResultDelegate :AnyObject{
   func restarted()
   func ended()
}


class ResultViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var endButton: UIButton!

    var winner:Winners!
    weak var delegate:MatchResultDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setButtons()

    }
    func setButtons() {
        restartButton.layer.cornerRadius = 20
        restartButton.titleEdgeInsets = UIEdgeInsets(top: 0,left: 10,bottom: 0,right: 10)
        endButton.layer.cornerRadius = 20
        endButton.titleEdgeInsets = UIEdgeInsets(top: 0,left: 10,bottom: 0,right: 10)
    }

    func setTableView() {
        tableView.register(UINib(nibName: "ResultCell", bundle: nil), forCellReuseIdentifier: "ResultCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
    }

    @IBAction func restartMatch(_ sender: Any) {
        self.delegate?.restarted()
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func endMatch(_ sender: Any) {
        self.delegate?.ended()
        self.dismiss(animated: true, completion: nil)
    }

    
}

extension ResultViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as? ResultCell {
            cell.setWinner(winner:winner, index: indexPath.row)
            return cell
        }
        return UITableViewCell()
    }

    
}
