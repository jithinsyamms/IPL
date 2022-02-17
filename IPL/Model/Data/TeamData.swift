//
//  TeamData.swift
//  IPL
//
//  Created by Jithin on 15/02/22.
//

import Foundation

struct IPLTeams: Codable {
    let teams: [IPLTeam]
}

struct IPLTeam: Codable {
    let teamID: Int
    let teamName, caption, brandColor: String

    enum CodingKeys: String, CodingKey {
        case teamID = "teamId"
        case teamName, caption, brandColor
    }
}
