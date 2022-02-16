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

    func setWinner(winner:Winners, index:Int) {

        switch index {
        case 0:
            header.text = "Winners"
            header.font = UIFont.systemFont(ofSize: 30)
            if let color = winner.winner?.brandColor {
                viewBackGround.backgroundColor = Utils.hexStringToUIColor(hex:color )
            }
            if let name = winner.winner?.teamName {
                teamName.text = name
            }

        case 1:
            header.text = "Runner Up"
            header.font = UIFont.systemFont(ofSize: 26)
            if let color = winner.firstRunnerUp?.brandColor {
                viewBackGround.backgroundColor = Utils.hexStringToUIColor(hex:color )
            }
            if let name = winner.firstRunnerUp?.teamName {
                teamName.text = name
            }
        case 2:
            header.font = UIFont.systemFont(ofSize: 22)
            header.text = "2nd Runner Up"
            if let color = winner.secondRunnerUp?.brandColor {
                viewBackGround.backgroundColor = Utils.hexStringToUIColor(hex:color )
            }
            if let name = winner.secondRunnerUp?.teamName {
                teamName.text = name
            }
        default:
            header.text = ""
        }



    }
    
}
