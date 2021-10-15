//
//  WorkoutTableViewCell.swift
//  FitBuddy
//
//  Created by Muhsana Chowdhury  on 31/1/21.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {

    @IBOutlet weak var exName: UILabel!
    @IBOutlet weak var rNo: UILabel!
    @IBOutlet weak var sNo: UILabel!
    @IBOutlet weak var wNo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
