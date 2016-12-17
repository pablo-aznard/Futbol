//
//  PlantillaCell.swift
//  Futbol
//
//  Created by Pruebas on 15/12/16.
//  Copyright © 2016 Pruebas. All rights reserved.
//

import UIKit

class PlantillaCell: UITableViewCell { 
    
    @IBOutlet weak var dorsal: UILabel!
    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var nombre: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
