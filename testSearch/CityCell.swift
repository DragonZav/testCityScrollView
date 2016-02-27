//
//  CityCell.swift
//  testSearch
//
//  Created by Chris Augg on 2/26/16.
//  Copyright © 2016 Auggie Doggie iOSware. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {
    
    
    @IBOutlet weak var cellCityLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()       

    }

    func configureCell(city: String) {
        
        cellCityLbl.text = city
    }
   
}
