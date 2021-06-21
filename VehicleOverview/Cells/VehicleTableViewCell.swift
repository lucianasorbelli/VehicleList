//
//  VehicleTableViewCell.swift
//  VehicleOverview
//
//  Created by Sorbelli, Luciana Brenda on 18/06/2021.
//

import UIKit

class VehicleTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var licenseLabel: UILabel!
    @IBOutlet weak var brandAndModelLabel: UILabel!
    @IBOutlet weak var distanceMtrs: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
