//
//  ProgramsTableViewCell.swift
//  FitBuddy
//
//  Created by Muhsana Chowdhury  on 29/1/21.
//

import UIKit

class ProgramsTableViewCell: UITableViewCell {

    @IBOutlet weak var myPlanProgramLable: UILabel!
    @IBOutlet weak var createProgramDay: UILabel!
    @IBOutlet weak var createProgramCategory: UILabel!
    @IBOutlet weak var cpTCellDay: UILabel!
    @IBOutlet weak var cpTCellCategory: UILabel!
    @IBOutlet weak var cpTCellBtn: UIButton!
    @IBOutlet weak var dExTCellEx: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
