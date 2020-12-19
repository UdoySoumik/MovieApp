//
//  FavouritesTableViewController.swift
//  GP_Movie
//
//  Created by Soumik on 19/12/20.
//

import UIKit

class FavouritesTableViewController: UITableViewController {

    var favList:[[String:Any]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favourites"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favListTableViewCell", for: indexPath) as! TrendingTableViewCell
        
        if let name = favList?[indexPath.row]["title"] as? String {
            cell.movieNameLabel.text = name
        }else if let name = favList?[indexPath.row]["name"] as? String{
            cell.movieNameLabel.text = name
        }
        else{
            cell.movieNameLabel.text = "Not Available"
        }
        let voteCount = "\(favList?[indexPath.row]["vote_count"] as? Int ?? 0)"
        cell.movieRating.text = "\(favList?[indexPath.row]["vote_average"] as? Double ?? 0.0)" + " (\(voteCount))"
        if let releaseDate = favList?[indexPath.row]["release_date"] as? String {
            cell.releaseDate.text = releaseDate
        }else if let airDate = favList?[indexPath.row]["first_air_date"] as? String{
            cell.releaseDate.text = airDate
        }
        else{
            cell.releaseDate.text = "Coming Soon"
        }
        
        if let imageURL = favList?[indexPath.row]["poster_path"] as? String{
            let imageURL = URL(string: "https://image.tmdb.org/t/p/w342" + imageURL)
            cell.moviePosterImage.sd_setImage(with: imageURL, placeholderImage: UIImage(), options: .progressiveLoad)
        }
        else{
            cell.moviePosterImage.image = UIImage()
        }
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var detailVC = storyboard?.instantiateViewController(identifier: "MovieDetailViewController") as? MovieDetailViewController
        detailVC?.movieID = self.favList?[indexPath.row]["id"] as? Int
        if favList?[indexPath.row]["first_air_date"] == nil{
            detailVC?.type = "movie"
        }else{
            detailVC?.type = "tv"
        }
        
        self.navigationController?.pushViewController(detailVC!, animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
