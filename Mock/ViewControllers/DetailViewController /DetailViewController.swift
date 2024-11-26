//
//  DetailViewController.swift
//  Mock
//
//  Created by DungHM on 26/11/24.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var dateLb: UILabel!
    @IBOutlet weak var categoryLb: UILabel!
    @IBOutlet weak var authorLb: UILabel!
    @IBOutlet weak var linkLb: UILabel!
    @IBOutlet weak var descriptionLb : UILabel!
    @IBOutlet weak var thumbnailImg: UIImageView!
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLb.text = event?.title ?? ""
        self.authorLb.text = event?.author ?? ""
        self.thumbnailImg.image = event?.thumbnailImg ?? UIImage()
        self.descriptionLb.text = event?.description ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "'Thứ 'e', 'yyyy/MM/dd"
        self.dateLb.text = dateFormatter.string(from: event?.date ?? Date())
        self.navigationController?.navigationBar.isHidden = true
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
