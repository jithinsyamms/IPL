//
//  TeamCell.swift
//  IPL
//
//  Created by Jithin on 15/02/22.
//

import UIKit

class TeamCell: UICollectionViewCell {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var tagLine: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func setTeam(team: Team?) {
        teamName.text = team?.teamName
        tagLine.text = team?.caption

        viewBackground.layer.cornerRadius = 10
        viewBackground.layer.borderColor = UIColor.lightGray.cgColor
        viewBackground.layer.borderWidth = 0.5

        if let team = team, let color = team.brandColor {
            viewBackground.backgroundColor = Utils.hexStringToUIColor(hex: color)
        }
    }

}
