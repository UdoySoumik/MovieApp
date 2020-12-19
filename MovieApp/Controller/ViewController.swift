//
//  ViewController.swift
//  MovieApp
//
//  Created by Soumik on 19/12/20.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var homeTableView: UITableView!
    
    var trendingContentArr = [[String:Any]]()
    var popularMoviesArr = [[String:Any]]()
    var popularTVSeriesArr = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ApiManager.shared.fetchTrendingContent { (success, err, recievedData) in
            print(recievedData)
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
            cell?.movieNameLabel.text = trendingContentArr[indexPath.row]["title"] as? String
            cell?.movieRating.text = "\(trendingContentArr[indexPath.row]["vote_average"] as? Double ?? 0.0)"
            cell?.releaseDate.text = trendingContentArr[indexPath.row]["release_date"] as? String
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


}

