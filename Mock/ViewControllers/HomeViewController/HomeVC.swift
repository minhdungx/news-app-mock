//
//  HomeVC.swift
//  Mock
//
//  Created by DungHM on 21/11/24.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var newsBtn: UIButton!
    @IBOutlet weak var eventBtn: UIButton!
    @IBOutlet weak var newsUnderscore : UIView!
    @IBOutlet weak var eventUnderscore : UIView!
    @IBOutlet weak var navBar : UIView!
    @IBOutlet weak var pageFrame : UIView!

    

    var modeNews = true {
        didSet {
            newsBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: modeNews ? .bold : .light)
            eventBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: modeNews ? . light : .bold)
            newsUnderscore.isHidden = !modeNews
            eventUnderscore.isHidden = modeNews
            self.pageController?.setViewControllers([modeNews ? self.VCs[0] : self.VCs[1]] ,direction: !modeNews ? .forward : .reverse, animated: true )
            if modeNews {
                self.pageController?.setViewControllers([self.VCs[0]], direction: .forward, animated: true)
            } else {
                self.pageController?.setViewControllers([self.VCs[1]], direction: .reverse, animated: true)
            }
        }
    }

    
    private var pageController: UIPageViewController?
    private var currentIndex : Int = 0
    private var VCs = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modeNews = true
       
        
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageController?.dataSource = self
        self.pageController?.delegate = self
        self.pageController?.view.backgroundColor = .clear
        self.pageController?.view.frame = pageFrame.frame
        self.addChild(self.pageController!)
        self.view.addSubview(self.pageController!.view)
        self.pageController?.didMove(toParent: self)
        let newsVC = NewsVC()
        newsVC.homeVC = self
        let eventVC = EventVC()
        self.VCs = [newsVC, eventVC]
        self.pageController?.setViewControllers([self.VCs[0]], direction: .forward, animated: false)
    }
    
        func viewDetail(event: () -> Event) {
            let event = event()
            let detailVC = DetailViewController()
            detailVC.event = event
            self.tabBarController?.navigationController?.pushViewController(detailVC, animated: true)
        }
    
    @IBAction func newsTab (_ sender: UIButton){
        modeNews = true
    }
    
    @IBAction func eventTab (_ sender: UIButton){
        modeNews = false
    }

}

extension HomeVC: newsDelegate {
    func eventPass(event: Event){
        let detailVC = DetailViewController()
        detailVC.event = event
        self.tabBarController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension HomeVC : UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let curId = self.VCs.firstIndex(of: viewController) else {return nil}
        let nextId = curId + 1
        if nextId < self.VCs.count {
            return self.VCs[nextId]
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let curId = self.VCs.firstIndex(of: viewController) else {return nil}
        let previousId = curId - 1
        if previousId >= 0 {
            return self.VCs[previousId]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed == true {
            self.modeNews = !self.modeNews
        }
    }
    

}
