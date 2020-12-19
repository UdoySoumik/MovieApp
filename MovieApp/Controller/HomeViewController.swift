//
//  ViewController.swift
//  MovieApp
//
//  Created by Soumik on 19/12/20.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController{
    
    var refreshControl = UIRefreshControl()
    @IBOutlet weak var homeTableView: UITableView!
    
    var trendingContentArr = [[String:Any]]()
    var popularMoviesArr = [[String:Any]]()
    var popularTVSeriesArr = [[String:Any]]()
    var checkDoneCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
    
        self.homeTableView.separatorStyle = .singleLine
        self.homeTableView.separatorColor = UIColor.yellow
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh",attributes: [NSAttributedString.Key.foregroundColor:UIColor.yellow])
        refreshControl.tintColor = UIColor.yellow
        
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.homeTableView.addSubview(refreshControl)
        // Do any additional setup after loading the view.
        self.view.showBlurLoader()
        refresh(nil)
    }
    
    func removeLoadingifDone(){
        if self.checkDoneCounter == 0{
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.view.removeBluerLoader()
            }
        }
    }
    @objc func refresh(_ sender: AnyObject?) {
       // Code to refresh table view
        checkDoneCounter += 1
        ApiManager.shared.fetchPopularMovies{ (success, err, recievedData) in
           // print(recievedData)
            if err != nil{
                self.showErrorPopup(err?.localizedDescription ?? "Connectivity Issue")
            }
            self.checkDoneCounter-=1
            self.removeLoadingifDone()
            if let contentArr = recievedData{
                self.popularMoviesArr = contentArr
                DispatchQueue.main.async {
                    self.homeTableView.reloadData()
                }
                
            }
        }
        checkDoneCounter+=1
        ApiManager.shared.fetchPopularSeries{ (success, err, recievedData) in
           // print(recievedData)
            if err != nil{
                self.showErrorPopup(err?.localizedDescription ?? "Connectivity Issue")
            }
            self.checkDoneCounter-=1
            self.removeLoadingifDone()
            if let contentArr = recievedData{
                self.popularTVSeriesArr = contentArr
                DispatchQueue.main.async {
                    self.homeTableView.reloadData()
                }
                
            }
        }
        checkDoneCounter+=1
        ApiManager.shared.fetchTrendingContent { (success, err, recievedData) in
           // print(recievedData)
            if err != nil{
                self.showErrorPopup(err?.localizedDescription ?? "Connectivity Issue")
            }
            self.checkDoneCounter-=1
            self.removeLoadingifDone()
            if let contentArr = recievedData{
                self.trendingContentArr = contentArr
                DispatchQueue.main.async {
                    self.homeTableView.reloadSections([2], with: .none)
                }
                
            }
        }
    }
    
    func showErrorPopup(_ message:String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    
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
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionTableViewCell", for: indexPath) as? CollectionTableViewCell
            cell?.indexPath = indexPath
            cell?.horizontalCollectionView.reloadData()
            return cell ?? UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionTableViewCell", for: indexPath) as? CollectionTableViewCell
            cell?.indexPath = indexPath
            cell?.horizontalCollectionView.reloadData()
            return cell ?? UITableViewCell()
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell", for: indexPath) as? TrendingTableViewCell
            if let name = trendingContentArr[indexPath.row]["title"] as? String {
                cell?.movieNameLabel.text = name
            }else if let name = trendingContentArr[indexPath.row]["name"] as? String{
                cell?.movieNameLabel.text = name
            }
            else{
                cell?.movieNameLabel.text = "Not Available"
            }
            let voteCount = "\(trendingContentArr[indexPath.row]["vote_count"] as? Int ?? 0)"
            cell?.movieRating.text = "\(trendingContentArr[indexPath.row]["vote_average"] as? Double ?? 0.0)" + " (\(voteCount))"
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
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
        
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
        return 350
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.yellow
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2{
            var detailVC = storyboard?.instantiateViewController(identifier: "MovieDetailViewController") as? MovieDetailViewController
            detailVC?.movieID = self.trendingContentArr[indexPath.row]["id"] as? Int
            detailVC?.type = self.trendingContentArr[indexPath.row]["media_type"] as? String
            self.navigationController?.pushViewController(detailVC!, animated: true)
        }
    }
    
}

extension HomeViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let collectionTableCell = collectionView.superview?.superview as? CollectionTableViewCell{
            switch collectionTableCell.indexPath?.section {
            case 0:
                return self.popularMoviesArr.count
            case 1:
                return self.popularTVSeriesArr.count
            default:
                return 0
                break
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      //  let contentInfo = parentDelegate?.getItemForCell(atIndex: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell
        var contentInfo:[String:Any]
        if let collectionTableCell = collectionView.superview?.superview as? CollectionTableViewCell{
            switch collectionTableCell.indexPath?.section {
            case 0:
                contentInfo = self.popularMoviesArr[indexPath.row]
                break
            case 1:
                contentInfo = self.popularTVSeriesArr[indexPath.row]
                break
            default:
                return UICollectionViewCell()
                break
            }
            
            if let name = contentInfo["title"] as? String {
                cell?.movieNameLabel.text = name
            }else if let name = contentInfo["name"] as? String{
                cell?.movieNameLabel.text = name
            }
            else{
                cell?.movieNameLabel.text = "Not Available"
            }
            let voteCount = "\(contentInfo["vote_count"] as? Int ?? 0)"
            cell?.movieRating.text = "\(contentInfo["vote_average"] as? Double ?? 0.0)" + " (\(voteCount))"
            if let releaseDate = contentInfo["release_date"] as? String {
                cell?.releaseDate.text = releaseDate
            }else if let airDate = contentInfo["first_air_date"] as? String{
                cell?.releaseDate.text = airDate
            }
            else{
                cell?.releaseDate.text = "Coming Soon"
            }
            
            if let imageURL = contentInfo["poster_path"] as? String{
                let imageURL = URL(string: "https://image.tmdb.org/t/p/w342" + imageURL)
                cell?.moviePosterImage.sd_setImage(with: imageURL, placeholderImage: UIImage(), options: .progressiveLoad)
            }
            else{
                cell?.moviePosterImage.image = UIImage()
            }
            
        }
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 270, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var contentInfo:[String:Any]
        var type = ""
        if let collectionTableCell = collectionView.superview?.superview as? CollectionTableViewCell{
            switch collectionTableCell.indexPath?.section {
            case 0:
                contentInfo = self.popularMoviesArr[indexPath.row]
                type = "movie"
                break
            case 1:
                contentInfo = self.popularTVSeriesArr[indexPath.row]
                type = "tv"
                break
            default:
                contentInfo = [String:Any]()
                break
            }
            
            let detailVC = storyboard?.instantiateViewController(identifier: "MovieDetailViewController") as? MovieDetailViewController
            detailVC?.movieID = contentInfo["id"] as? Int
            detailVC?.type = type
            self.navigationController?.pushViewController(detailVC!, animated: true)
        }
    }
    
}

