//
//  DetailViewController.swift
//  Mock
//
//  Created by DungHM on 20/11/24.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var nameLB: UILabel!
    var name: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLB.text = name
    }
}
