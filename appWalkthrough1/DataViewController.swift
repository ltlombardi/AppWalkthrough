//
//  DataViewController.swift
//  appWalkthrough1
//
//  Created by Leonardo Lombardi on 9/27/16.
//  Copyright © 2016 Leonardo Lombardi. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel!.text = dataObject
    }

    @IBAction func previousPage(sender: UIButton) {
        getPageViewController().changePage(.Reverse, controller: self)
    }
    
    @IBAction func nextPage(sender: UIButton) {
        getPageViewController().changePage(.Forward, controller: self)
    }
    
    func getPageViewController() -> RootViewController {
        return self.parentViewController?.parentViewController as! RootViewController
    }

}

