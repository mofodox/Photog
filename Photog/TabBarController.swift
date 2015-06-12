//
//  TabBarController.swift
//  Photog
//
//  Created by Khairul Akmal on 12/06/2015.
//  Copyright (c) 2015 Khairul Akmal. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        var feedViewController = UIViewController()
        feedViewController.view.backgroundColor = UIColor.orangeColor()
        
        var profileViewController = UIViewController()
        profileViewController.view.backgroundColor = UIColor.yellowColor()
        
        var findPeopleViewController = UIViewController()
        findPeopleViewController.view.backgroundColor = UIColor.blueColor()
        
        var cameraViewController = UIViewController()
        cameraViewController.view.backgroundColor = UIColor.purpleColor()
        
        var viewControllers = [feedViewController, profileViewController, findPeopleViewController, cameraViewController]
        self.setViewControllers(viewControllers, animated: true)
        
        var imageNames = ["FeedIcon", "ProfileIcon", "SearchIcon", "CameraIcon"]
        
        let tabItems = tabBar.items as! [UITabBarItem]
        for (index, value) in enumerate(tabItems) {
            var imageName = imageNames[index]
            value.image = UIImage(named: imageName)
            // Adjust the tabBarItem images to be centered
            value.imageInsets = UIEdgeInsetsMake(5.0, 0, -5.0, 0)
        }
        
        self.edgesForExtendedLayout = .None
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .Done, target: self, action: "didTapSignOut:")
        self.tabBar.translucent = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "Photog"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didTapSignOut(sender: AnyObject) {
        PFUser.logOut()
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

}
