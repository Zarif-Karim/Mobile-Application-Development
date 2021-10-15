//
//  ExerciseTableViewCell.swift
//  FitBuddy
//
//  Created by Muhsana Chowdhury  on 27/1/21.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {

    @IBOutlet weak var tCell: UILabel!
    @IBOutlet weak var tCellID: UILabel!
    @IBOutlet weak var mExCID: UILabel!
    @IBOutlet weak var mExCName: UILabel!
    @IBOutlet weak var mExCCat: UILabel!
    @IBOutlet weak var exLableMain: UILabel!
    @IBOutlet weak var exCatToEx: UIButton!
    @IBOutlet weak var exExtoDes: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
