//
//  CollectionTableViewCell.swift
//  MovieApp
//
//  Created by Soumik on 19/12/20.
//

import UIKit

protocol collectionTableViewCellProtocol{
    func collectionViewNumberOfItems(inSection:Int)->Int
    func getItemForCell(atIndex:IndexPath)->[String:Any]
}

class CollectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var horizontalCollectionView: UICollectionView!
    
    var indexPath:IndexPath?
    
    var parentDelegate:collectionTableViewCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
