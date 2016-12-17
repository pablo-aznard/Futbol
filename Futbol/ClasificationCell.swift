//
//  ClasificationCell.swift
//  Futbol
//
//  Created by Pruebas on 15/12/16.
//  Copyright © 2016 Pruebas. All rights reserved.
//

import UIKit

class ClasificationCell: UITableViewCell {

    @IBOutlet weak var numero: UILabel!
    @IBOutlet weak var escudo: UIImageView!
    @IBOutlet weak var equipo: UILabel!
    @IBOutlet weak var puntos: UILabel!


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
