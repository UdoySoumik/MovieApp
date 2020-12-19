//
//  MovieDetailViewController.swift
//  GP_Movie
//
//  Created by Soumik on 19/12/20.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var postarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    var movieInfoDetail:[String:Any]?
    var movieID:Int?
    var type:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let id = movieID{
            ApiManager.shared.fetchMovieDetail(forID: id, forType:type ?? "movie") { (success, err, data) in
                self.movieInfoDetail = data
                DispatchQueue.main.async {
                    self.nameLabel.text = data?["title"] as? String
                    
                    if let name = data?["title"] as? String {
                        self.nameLabel.text = name
                    }else if let name = data?["name"] as? String{
                        self.nameLabel.text = name
                    }
                    
                    self.title = self.nameLabel.text
                    self.descriptionLabel.text = data?["overview"] as? String
                    
                    if let time = data?["runtime"] as? Int{
                        self.durationLabel.text = "\(time)" + " min"
                    }else{
                        self.durationLabel.isHidden = true
                    }
                    
                    
 
                    if let imgPath = data?["poster_path"] as? String, let imgURL = URL(string:"https://image.tmdb.org/t/p/w342\(imgPath)" ){
                        self.postarImageView.sd_setImage(with: imgURL, placeholderImage: UIImage(), options: .progressiveLoad)
                    }
                }
                
                
            }
        }
        

        // Do any additional setup after loading the view.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func addFavouriteButtonPressed(_ sender: UIButton) {
    }
    
}
