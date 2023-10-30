//
//  StarwarsTableViewCell.swift
//  lazyloading
//
//  Created by Chinedu Uche on 30/10/2023.
//

import UIKit

class StarwarsTableViewCell: UITableViewCell {
    
    var task = Task {}
    

    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        starImageView.image = UIImage(systemName: "person")
        task.cancel()
    }

}
