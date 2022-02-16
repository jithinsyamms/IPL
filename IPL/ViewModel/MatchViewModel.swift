//
//  MatchViewModel.swift
//  IPL
//
//  Created by Jithin on 16/02/22.
//

import Foundation

protocol MatchViewModelDelegate: AnyObject {
    func setMatches(matches:[Match])
    func setTeams(teams:[Team])
    func seasonFinished(winners:Winners)
}

class MatchViewModel {

    weak var delegate: MatchViewModelDelegate?

    var seasonWinners:Winners = Winners()

    func prepareMatches(teams:[Team]?){
        var matches:[Match] = []
        if var teams = teams {
            teams.shuffle()
            var index = 0;
            while index + 1 < teams.count {
                let match = Match(team: teams[index], opponent: teams[index + 1])
                matches.append(match)
                index += 2
            }
        }
        self.delegate?.setMatches(matches: matches)
    }

    func playMatches(matches:[Match]?) {

        var currentWinners:[Team] = []
        var losers:[Team] = []

        if let matches = matches {
            if matches.count == 1 {
                setWinners(match: matches[0])
                self.delegate?.seasonFinished(winners: seasonWinners)
            } else {
                for match in matches {
                    let matchTuple = match.getWinner()
                    currentWinners.append(matchTuple.winner)
                    losers.append(matchTuple.loser)
                    if matches.count == 2 && losers.count == 2 {
                        playLoosersFinal(losers: losers)
                    }
                }
                self.delegate?.setTeams(teams: currentWinners)
                prepareMatches(teams: currentWinners)
            }
        }
    }

    func playLoosersFinal(losers:[Team]){
         let loosersFinal = Match(team: losers[0], opponent: losers[1])
         seasonWinners.secondRunnerUp = loosersFinal.getWinner().winner
    }

    func setWinners(match:Match) {
        let results = match.getWinner()
        seasonWinners.winner = results.winner
        seasonWinners.firstRunnerUp = results.loser
    }
}
