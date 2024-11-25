//
//  NewsVC.swift
//  Mock
//
//  Created by DungHM on 22/11/24.
//

import UIKit

class NewsVC: UIViewController {

    @IBOutlet weak var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "HomeCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        loadAPI2()
        
    }
    
    var articles: [Article] = []
    
    var q = "arcane"
    var page = 1
    var pageSize = 10
    
    @objc func loadAPI2() {
            print("LOAD API")
            loadAPI { (done, msg) in
                if done {
                    self.tableView.reloadData()
                } else {
                    print("API ERROR: \(msg)")
                }
            }
        }
    
    func loadAPI(completion: @escaping Completion) {
        let urlString = "https://newsapi.org/v2/everything?q=\(q)&apiKey=\(API_KEY)&pageSize=\(pageSize)&page=\(page)"
        
        NetworkingManager.shared().request(with: urlString) { (data, error) in
            if let error = error {
                completion (false, error.localizedDescription)
            } else {
                if let data = data {
                    let json = data.toJSON()
                    let results  = json["articles"] as! [JSON]
                    
                    for item in results {
                        let article = Article(json: item)
                        self.articles.append(article)
                        
                        completion(true, "" )
                    }
                } else {
                    completion(false, "Data format is error")
                }
            }
        }
        
    }

}

extension NewsVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeCell
        if let cell = cell {
            let item = articles[indexPath.row]
            cell.titleLb.text = item.title
            cell.authorLb.text = "Bởi \(item.author ?? "")"
            cell.sourceLb.text = "Từ \(item.source ?? "")"
            
            if item.thumbnailImg != nil {
                cell.thumnailImg.image = item.thumbnailImg
            } else {
                cell.thumnailImg.image = nil
                
                NetworkingManager.shared().downloadImage(url: item.thumbnalURL ?? "" ) { (image) in
                    if let image = image {
                        cell.thumnailImg.image = image
                        item.thumbnailImg = image
                    } else {
                        cell.thumnailImg.image = nil 
                    }
                }
            }
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
