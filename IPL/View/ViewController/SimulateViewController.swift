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

    var initialTeams: [Team]?
    var matches: [Match]?
    var teams: [Team]?
    var matchViewModel = MatchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setTableView()
        setButton()
        initialTeams = teams
        matchViewModel.delegate = self
        matchViewModel.prepareMatches(teams: teams)
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
        self.navigationItem.hidesBackButton = true
        setNavTitle()
    }

    func setNavTitle() {

        switch matches?.count {
        case 2:
            self.navigationItem.title = "SEMI-FINAL"
        case 1:
            self.navigationItem.title = "FINAL"
        default:
            self.navigationItem.title = "KNOCK OUT"
        }


    }

    func setButton() {
        simulateButton.layer.cornerRadius = 20
        simulateButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }

    @IBAction func simulateTapped(_ sender: Any) {
        matchViewModel.playMatches(matches: self.matches)
    }

    func updateTableViewContentInset() {
        let tableViewHeight = self.tableView.frame.height
        let contentHeight = self.tableView.contentSize.height
        let centeringInset = (tableViewHeight - contentHeight) / 2
        let topInset = max(centeringInset, 0.0)
        self.tableView.contentInset = UIEdgeInsets(top: topInset, left: 0.0, bottom: 0.0, right: 0.0)
    }

}

extension SimulateViewController: MatchResultDelegate {

    func restarted() {
        teams = initialTeams
        matchViewModel.prepareMatches(teams: teams)
    }

    func ended() {
        self.navigationController?.popToRootViewController(animated: true)
    }

}

extension SimulateViewController: MatchViewModelDelegate {

    func setMatches(matches: [Match]) {
        self.matches = matches
        if matches.count == 1 {
            simulateButton.setTitle("Simulate & End", for: .normal)
        } else {
            simulateButton.setTitle("Simulate", for: .normal)
        }

        UIView.animate(withDuration: 0.0) {
            self.tableView.reloadData()
        } completion: { _ in
            self.updateTableViewContentInset()
            self.setNavTitle()
        }
    }

    func setTeams(teams: [Team]) {
        self.teams = teams
    }

    func seasonFinished(winners: Winners) {
        self.teams = self.initialTeams
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let resultController = storyboard.instantiateViewController(identifier:
                                  "ResultViewController") as? ResultViewController {

            resultController.modalPresentationStyle = .fullScreen
            resultController.winner = winners
            resultController.delegate = self
            present(resultController, animated: true, completion: nil)
        }
    }

}

extension SimulateViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension SimulateViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MatchCell",
                      for: indexPath) as? MatchCell {
            cell.setMatch(match: matches?[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

}
