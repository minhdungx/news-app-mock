//
//  CategoryVC.swift
//  Mock
//
//  Created by DungHM on 21/11/24.
//

import UIKit

class CategoryVC: UIViewController {
    @IBOutlet weak var categoryTable: UITableView!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchBox: UITextField!
    @IBOutlet weak var titleLB : UILabel!

    
    var searchMode = false {
        didSet {
            searchBtn.isHidden = searchMode
            searchBox.isHidden = !searchMode
            titleLB.isHidden = searchMode
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTable.dataSource = self
        categoryTable.delegate = self
        let nib = UINib(nibName: "CategoryCell", bundle: .main)
        categoryTable.register(nib, forCellReuseIdentifier: "cell")
        searchMode = false
        self.navigationController?.isNavigationBarHidden = true
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Danh mục"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)

        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }
    
    @IBAction func search(_ sender: UIButton){
        searchMode = true
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        searchMode = false
    }

}

extension CategoryVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoryTable.dequeueReusableCell(withIdentifier: "cell") as? CategoryCell
        if let catCell = cell {
            return catCell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
