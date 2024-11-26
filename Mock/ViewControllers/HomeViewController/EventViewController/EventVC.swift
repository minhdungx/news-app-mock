//
//  EventVC.swift
//  Mock
//
//  Created by DungHM on 22/11/24.
//

import UIKit

class EventVC: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    
    var events: [Event] = []
    var q = "f1"
    var page = 1
    var pageSize = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "EventCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadAPI2(pageNum: page)
    }
    
    
    func loadAPI2(pageNum: Int) {
            print("LOAD API")
        loadAPI(pageNum: pageNum) { (done, msg) in
                if done {
                    self.tableView.reloadData()
                } else {
                    print("API ERROR: \(msg)")
                }
            }
        }
    
    func loadAPI(pageNum: Int, completion: @escaping Completion ) {
        let urlString = "https://newsapi.org/v2/everything?q=\(q)&apiKey=\(API_KEY)&pageSize=\(pageSize)&page=\(pageNum)"
        
        NetworkingManager.shared().request(with: urlString) { (data, error) in
            if let error = error {
                completion (false, error.localizedDescription)
            } else {
                if let data = data {
                    let json = data.toJSON()
                    let results  = json["articles"] as! [JSON]
                    for item in results {
                        let event = Event(json: item)
                        self.events.append(event)
                        
                        completion(true, "" )
                    }
                } else {
                    completion(false, "Data format is error")
                }
            }
        }
        
    }

}

extension EventVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? EventCell
        if let cell = cell {
            let item = events[indexPath.row]
            cell.titleLb.text = item.title
            if item.thumbnailImg != nil {
                cell.thumbnailImg.image = item.thumbnailImg
            } else {
                cell.thumbnailImg.image = nil
                
                NetworkingManager.shared().downloadImage(url: item.thumbnailURL ?? "" ) { (image) in
                    if let image = image {
                        cell.thumbnailImg.image = image
                        item.thumbnailImg = image
                    } else {
                        cell.thumbnailImg.image = nil
                    }
                }
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "'Thứ 'e', 'yyyy/MM/dd"
            cell.dateLb.text = dateFormatter.string(from: item.date ?? Date())
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement  = events.count - 3
        if indexPath.row == lastElement {
            self.page += 1
            loadAPI2(pageNum: self.page)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC  = DetailViewController()
        let item = events[indexPath.row]
        detailVC.event = item
        self.navigationController?.pushViewController(detailVC , animated: true)
    }
}
    

