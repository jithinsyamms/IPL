//
//  MatchCell.swift
//  IPL
//
//  Created by Jithin on 16/02/22.
//

import UIKit

class MatchCell: UITableViewCell {

    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var opponentName: UILabel!
    @IBOutlet weak var teamBackground: UIView!
    @IBOutlet weak var opponentBackground: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        teamBackground.layer.cornerRadius = 10
        teamBackground.layer.borderColor = UIColor.lightGray.cgColor
        teamBackground.layer.borderWidth = 0.5
        opponentBackground.layer.cornerRadius = 10
        opponentBackground.layer.borderColor = UIColor.lightGray.cgColor
        opponentBackground.layer.borderWidth = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setMatch(match: Match?) {
        teamName.text = match?.team.teamName
        opponentName.text =  match?.opponent.teamName
        

        if let match = match, let teamColor = match.team.brandColor, let opponentColor = match.opponent.brandColor {
            teamBackground.backgroundColor = Utils.hexStringToUIColor(hex: teamColor)
            opponentBackground.backgroundColor = Utils.hexStringToUIColor(hex: opponentColor)
        }
    }

}
