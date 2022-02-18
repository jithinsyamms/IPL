//
//  ResultCell.swift
//  IPL
//
//  Created by Jithin on 16/02/22.
//

import UIKit

class ResultCell: UITableViewCell {

    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var viewBackGround: UIView!
    @IBOutlet weak var teamName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewBackGround.layer.cornerRadius = 10
        viewBackGround.layer.borderColor = UIColor.lightGray.cgColor
        viewBackGround.layer.borderWidth = 0.5
        header.font = UIFont.systemFont(ofSize: 26)
        teamName.font = UIFont.systemFont(ofSize: 22)
        teamName.textColor = UIColor.white

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setWinner(winner: Winners, index: Int) {

        switch index {
        case 0:
            header.text = "Winners"
            header.font = UIFont.systemFont(ofSize: 30)
            setBackgroundColor(team: winner.winner )
            setTextColor(team: winner.winner)

        case 1:
            header.text = "Runner Up"
            header.font = UIFont.systemFont(ofSize: 26)
            setBackgroundColor(team: winner.firstRunnerUp)
            setTextColor(team: winner.firstRunnerUp)

        case 2:
            header.font = UIFont.systemFont(ofSize: 22)
            header.text = "2nd Runner Up"
            setBackgroundColor(team: winner.secondRunnerUp)
            setTextColor(team: winner.secondRunnerUp)

        default:
            header.text = ""
        }
    }

    func setBackgroundColor (team: Team?) {
        if let color = team?.brandColor {
            viewBackGround.backgroundColor = Utils.hexStringToUIColor(hex: color )
        }
    }

    func setTextColor (team: Team?) {
        if let name = team?.teamName {
            teamName.text = name
        }
    }
}
