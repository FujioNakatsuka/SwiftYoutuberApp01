//
//  Page5ViewController.swift
//  SwiftYoutuberApp01
//
//  Created by 中塚富士雄 on 2020/09/07.
//  Copyright © 2020 中塚富士雄. All rights reserved.
//

import UIKit
import SegementSlide
import Alamofire
import SwiftyJSON
import SDWebImage


class Page5ViewController: UITableViewController,SegementSlideContentScrollViewDelegate {
    
    var youtubeData = YoutubeData()
    
    var videoIdArray = [String]()
    var titleArray = [String]()
    var imageURLStringArray = [String]()
    var youtubeURLArray = [String]()
    var channelTitleArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
       
    }
    
    @objc var scrollView: UIScrollView{
        
        return tableView
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
   
        cell.selectionStyle = .none
        
        let profileImageURL = URL(string: self.imageURLStringArray[indexPath.row] as String)!
        
         cell.imageView?.sd_setImage(with: profileImageURL, completed: {(image,error,_,_) in
                   
                   if error == nil{
                       
                       cell.setNeedsLayout()
                       
                   }
                   
               })
        
        cell.textLabel!.text = self.titleArray[indexPath.row]
        
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        
        cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
        
        cell.textLabel?.numberOfLines = 5
        
        cell.detailTextLabel?.numberOfLines = 5
        
        return cell
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        return titleArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        view.frame.size.height/5
                
    }
 
    func getData(){
        //リクエストを送る。JSON解析を行う。値が返ってくるので、for文で全て配列に入れる
         var text =  "https://www.googleapis.com/youtube/v3/search?key=AIzaSyDit4KTqyLvm4GaJG44bGaR48-ltwZZnYE&q=telemedicine&part=snippet&maxResults=19&order=date"
        
        //Almofireに入れる前に日本語を英語に変化する必要がある
        let url = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        //JSON解析
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default) .responseJSON{(responce) in
            
            print(responce)
            
            switch responce.result{
                
            case .success:
                
                for i in 0...19{
                    
                    let json:JSON = JSON(responce.data as Any)
                    //videoIdはidよりも下の階層にあるので、先にidを、次きにvideoIdを取得する。
                    let videoId = json["items"][i]["id"]["videoID"].string
                    let title = json["items"][i]["snippet"]["title"].string
                    let imageURLString = json["items"][i]["snippet"]["thumbnails"]["default"]["url"].string
                    let youtubeURL = "https://www.youtube.com/watch?v=\(videoId!)"
                    let channelTitle = json["items"][i]["snippet"]["channelTitle"].string
                    
                    self.videoIdArray.append(videoId!)
                    self.titleArray.append(title!)
                    self.imageURLStringArray.append(imageURLString!)
                    self.channelTitleArray.append(channelTitle!)
                    self.youtubeURLArray.append(youtubeURL)
                }
               break
                
            case .failure(let error):print(error)
                
                break
                
            }
            self.tableView.reloadData()
            
        }
            
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // ⭐️どこの行を変更したのかを知らせる？
        let indexNumber = indexPath.row
        
        let webViewControler = WebViewController()
        
        let url = youtubeURLArray[indexNumber]
        
        //⭐️urlの記録を保持する。このurlは何を指しているのか❓
        UserDefaults.standard.set(url, forKey: "url")
        
        present(webViewControler, animated: true,completion: nil)
        
        
        
    }
    
    
    
}
    
    


