//
//  TrendingTableViewCell.swift
//  MovieApp
//
//  Created by Soumik on 19/12/20.
//

import UIKit

class TrendingTableViewCell: UITableViewCell {

    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
