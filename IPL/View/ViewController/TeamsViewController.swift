//
//  TeamsViewController.swift
//  IPL
//
//  Created by Jithin on 15/02/22.
//

import UIKit

class TeamsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var startButton: UIButton!
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(
            top: 10.0,
            left: 12.0,
            bottom: 10.0,
            right: 12.0)

    var teamsDataModel = TeamsDataModel()
    private var teams: [Team]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setButton()
        setNavBar()
        collectionView.register(UINib(nibName: "TeamCell", bundle: nil),
                                        forCellWithReuseIdentifier: "TeamCell")
        teamsDataModel.delegate = self
        teamsDataModel.fetchTeams()
    }

    func setButton() {
        startButton.layer.cornerRadius = 20
        startButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }

    func setNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor.systemBlue
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? SimulateViewController {
            controller.teams = self.teams
        }
    }

}

extension TeamsViewController: TeamsDataModelDelegate {
    func setTeams(teams: [Team]) {
        self.teams = teams
    }
}

extension TeamsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teams?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "TeamCell", for: indexPath) as? TeamCell {
                    cell.setTeam(team: teams?[indexPath.row])
                    return cell
                }
                return UICollectionViewCell()
    }
}

extension TeamsViewController: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
            let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
            let availableWidth = view.frame.width - paddingSpace
            let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem * 0.65)
        }

        func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                             insetForSectionAt section: Int) -> UIEdgeInsets {
            return sectionInsets
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return sectionInsets.left
        }

}
