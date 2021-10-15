//
//  LogsMainTableViewCell.swift
//  FitBuddy
//
//  Created by Muhsana Chowdhury  on 28/1/21.
//

import UIKit

class LogsMainTableViewCell: UITableViewCell {

    @IBOutlet weak var lgslblMain: UILabel!
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var prog: UILabel!
    @IBOutlet weak var cat: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
