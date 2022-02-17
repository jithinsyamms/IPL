//
//  TeamsViewModel.swift
//  IPL
//
//  Created by Jithin on 15/02/22.
//

import Foundation
import CoreData

protocol TeamsDataModelDelegate: AnyObject {
    func dataChanged(teams: [Team])
}

class TeamsDataModel {

    var coreDataManager: CoreDataManager!
    var teams: [Team]?
    weak var delegate: TeamsDataModelDelegate?

    init() {
        coreDataManager = CoreDataManager.shared
    }

    func fetchTeams() {
            if getTeamsCount() <= 0 {
                loadTeamsDataFromJson()
            }

            let fetchRequest: NSFetchRequest<Team> = Team.fetchRequest()
            let sortDescriptors = [NSSortDescriptor(key: "teamId", ascending: true)]
            fetchRequest.sortDescriptors = sortDescriptors
            do {
                teams = try coreDataManager.getManagedContext().fetch(fetchRequest)
                if let teams = teams {
                    delegate?.dataChanged(teams: teams)
                }
            } catch let error {
                print(error)
            }
        }

    func getTeamsCount() -> Int {
            let request: NSFetchRequest<Team> = Team.fetchRequest()
            if let totalTeams = try? coreDataManager.getManagedContext().fetch(request) {
                return totalTeams.count
            } else {
               return 0
            }
        }

    func loadTeamsDataFromJson() {
            let bundle = Bundle(for: type(of: self))
            guard let json = bundle.url(forResource: "teams", withExtension: "json") else {
                return
            }
            do {
                let jsonData = try Data(contentsOf: json)
                let teams = try JSONDecoder().decode(IPLTeams.self, from: jsonData)
                addTeams(teams: teams)

            } catch _ {

            }
    }

    func addTeams(teams: IPLTeams) {
        for teamFromJson in teams.teams {
            let team = Team(context: coreDataManager.getManagedContext())
            team.teamId =  Int16(teamFromJson.teamID)
            team.teamName = teamFromJson.teamName
            team.caption = teamFromJson.caption
            team.brandColor = teamFromJson.brandColor
            team.position = 0
        }
        coreDataManager.saveContext()
    }
}
