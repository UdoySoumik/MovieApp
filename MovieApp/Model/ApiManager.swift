//
//  ApiManager.swift
//  MovieApp
//
//  Created by Soumik on 19/12/20.
//

import Foundation

class ApiManager{
    static let shared:ApiManager = ApiManager()
    
    func fetchTrendingContent(completion:@escaping (_ success:Bool,_ error:Error?, _ data:[[String:Any]]?)->Void){
        //let baseURL = URL(string: "https://api.themoviedb.org/3/trending/all/week")
        var components = URLComponents(string: "https://api.themoviedb.org/3/trending/all/week")
        components?.queryItems = [URLQueryItem(name: "api_key", value: "1a97f3b8d5deee1d649c0025f3acf75c")]
        if let derivedURL = components?.url{
            var request = URLRequest(url: derivedURL, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 10.0)
            
            request.httpMethod = "GET"
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                if error != nil{
                    completion(false,error,nil)
                    return
                }
                guard let recievedData = data else {
                    completion(false,nil,nil)
                    return
                }
                
                do{
                    let jsonData = try JSONSerialization.jsonObject(with: recievedData, options: .allowFragments) as? [String:Any]
                    if let contentDict = jsonData?["results"] as? [[String:Any]]{
                        completion(true,nil,contentDict)
                    }
                    else{
                        completion(false,nil,nil)
                    }
                }
                catch{
                    completion(false,nil,nil)
                }
            }
            dataTask.resume()
        }
        
    }
    
    func fetchPopularMovies(completion:@escaping (_ success:Bool,_ error:Error?, _ data:[[String:Any]]?)->Void){
        //let baseURL = URL(string: "https://api.themoviedb.org/3/trending/all/week")
        var components = URLComponents(string: "https://api.themoviedb.org/3/discover/movie")
        components?.queryItems = [URLQueryItem(name: "api_key", value: "1a97f3b8d5deee1d649c0025f3acf75c")]
        if let derivedURL = components?.url{
            var request = URLRequest(url: derivedURL, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 10.0)
            
            request.httpMethod = "GET"
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                if error != nil{
                    completion(false,error,nil)
                    return
                }
                guard let recievedData = data else {
                    completion(false,nil,nil)
                    return
                }
                
                do{
                    let jsonData = try JSONSerialization.jsonObject(with: recievedData, options: .allowFragments) as? [String:Any]
                    if let contentDict = jsonData?["results"] as? [[String:Any]]{
                        completion(true,nil,contentDict)
                    }
                    else{
                        completion(false,nil,nil)
                    }
                }
                catch{
                    completion(false,nil,nil)
                }
            }
            dataTask.resume()
        }
        
    }
    
    func fetchPopularSeries(completion:@escaping (_ success:Bool,_ error:Error?, _ data:[[String:Any]]?)->Void){
        //let baseURL = URL(string: "https://api.themoviedb.org/3/trending/all/week")
        var components = URLComponents(string: "https://api.themoviedb.org/3/discover/tv")
        components?.queryItems = [URLQueryItem(name: "api_key", value: "1a97f3b8d5deee1d649c0025f3acf75c")]
        if let derivedURL = components?.url{
            var request = URLRequest(url: derivedURL, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 10.0)
            
            request.httpMethod = "GET"
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                if error != nil{
                    completion(false,error,nil)
                    return
                }
                guard let recievedData = data else {
                    completion(false,nil,nil)
                    return
                }
                
                do{
                    let jsonData = try JSONSerialization.jsonObject(with: recievedData, options: .allowFragments) as? [String:Any]
                    if let contentDict = jsonData?["results"] as? [[String:Any]]{
                        completion(true,nil,contentDict)
                    }
                    else{
                        completion(false,nil,nil)
                    }
                }
                catch{
                    completion(false,nil,nil)
                }
            }
            dataTask.resume()
        }
        
    }
}
