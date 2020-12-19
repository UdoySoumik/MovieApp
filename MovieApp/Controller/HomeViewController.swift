//
//  ViewController.swift
//  MovieApp
//
//  Created by Soumik on 19/12/20.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var homeTableView: UITableView!
    
    var trendingContentArr = [[String:Any]]()
    var popularMoviesArr = [[String:Any]]()
    var popularTVSeriesArr = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ApiManager.shared.fetchTrendingContent { (success, err, recievedData) in
           // print(recievedData)
            if let contentArr = recievedData{
                self.trendingContentArr = contentArr
                DispatchQueue.main.async {
                    self.homeTableView.reloadSections([2], with: .none)
                }
                
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else if section == 1{
            return 1
        }
        else{
            return trendingContentArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell", for: indexPath) as? TrendingTableViewCell
        switch indexPath.section {
        case 0:
            break
        case 1:
            break
        case 2:
            
            if let name = trendingContentArr[indexPath.row]["title"] as? String {
                cell?.movieNameLabel.text = name
            }else if let name = trendingContentArr[indexPath.row]["name"] as? String{
                cell?.movieNameLabel.text = name
            }
            else{
                cell?.movieNameLabel.text = "Not Available"
            }
            
            cell?.movieRating.text = "\(trendingContentArr[indexPath.row]["vote_average"] as? Double ?? 0.0)"
            if let releaseDate = trendingContentArr[indexPath.row]["release_date"] as? String {
                cell?.releaseDate.text = releaseDate
            }else if let airDate = trendingContentArr[indexPath.row]["first_air_date"] as? String{
                cell?.releaseDate.text = airDate
            }
            else{
                cell?.releaseDate.text = "Coming Soon"
            }
            
            if let imageURL = trendingContentArr[indexPath.row]["poster_path"] as? String{
                let imageURL = URL(string: "https://image.tmdb.org/t/p/w342" + imageURL)
                cell?.moviePosterImage.sd_setImage(with: imageURL, placeholderImage: UIImage(), options: .progressiveLoad)
            }
            else{
                cell?.moviePosterImage.image = UIImage()
            }
            
            break
        default:
            break
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Popular Movies"
        }
        else if section == 1{
            return "Popular TV Series"
        }
        else{
            return "Trending Content"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

}

