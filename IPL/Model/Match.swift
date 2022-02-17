//
//  Match.swift
//  IPL
//
//  Created by Jithin on 16/02/22.
//

import Foundation

struct Match {
    var team: Team
    var opponent: Team

    func getWinner() -> (winner: Team, loser: Team) {
        return Int.random(in: 1...2) == 1 ? (winner:team, loser:opponent) : (winner:opponent, loser:team)
    }

}
