//
//  SimulateViewController.swift
//  IPL
//
//  Created by Jithin on 16/02/22.
//

import UIKit

class SimulateViewController: UIViewController {

    @IBOutlet weak var simulateButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    var matches:[Match]?
    var teams:[Team]?
    var matchViewModel = MatchViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        matchViewModel.delegate = self
        simulateButton.layer.cornerRadius = 20
        simulateButton.titleEdgeInsets = UIEdgeInsets(top: 0,left: 10,bottom: 0,right: 10)
        matchViewModel.prepareMatches(teams: teams)
        setNavBar()
    }

    func setTableView() {
        tableView.register(UINib(nibName: "MatchCell", bundle: nil), forCellReuseIdentifier: "MatchCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
    }
    
    func setNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor.systemBlue
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    

    
    @IBAction func simulateTapped(_ sender: Any) {
        matchViewModel.eliminateTeams(matches: self.matches)
    }
}



extension SimulateViewController : MatchViewModelDelegate {
    func setMatches(matches: [Match]) {
        self.matches = matches
        tableView.reloadData()
    }

    func setTeams(teams: [Team]) {
        self.teams = teams
    }

    func seasonFinished(winners: Winners) {
        
    }

}

extension SimulateViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}

extension SimulateViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return matches?.count ?? 0
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MatchCell", for: indexPath) as? MatchCell{
            cell.setMatch(match: matches?[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

}
