//
//  CategoryDetailViewController.swift
//  Mock
//
//  Created by DungHM on 21/11/24.
//

import UIKit

class CategoryDetailViewController : UIViewController {
    @IBOutlet var tableview: UITableView!
    @IBOutlet weak var joinBtn : UIButton!
    @IBOutlet weak var joinedBtn: UIButton!
    @IBOutlet weak var joinUnderscore : UIView!
    @IBOutlet weak var joinedUnderscore : UIView!
    
    var deadline = ["Kết thúc hôm nay", "Kết thúc tuần này"]
    var modeJoin = true {
        didSet {
            joinBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: modeJoin ? .bold : .light)
            joinedBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: modeJoin ? . light : .bold)
            joinUnderscore.isHidden = !modeJoin
            joinedUnderscore.isHidden = modeJoin
            let nib = UINib(nibName: modeJoin ? "EventCell" : "EventCell", bundle: .main  )
            tableview.register(nib, forCellReuseIdentifier: "cell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "EventCell", bundle: .main  )
        tableview.register(nib, forCellReuseIdentifier: "cell")
        
        tableview.dataSource = self
        tableview.delegate = self
        modeJoin = true
        title = "Trang chủ"
        
    }
    
    @IBAction func joinTab (_ sender: UIButton){
        modeJoin = true
    }
    
    @IBAction func joinedTab (_ sender: UIButton){
        modeJoin = false
    }
}

extension CategoryDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? EventCell
        if let cel = cell {
            return cel
        } else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
       
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (deadline[section])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
        return 343
        
    }
    
    
}
