//
//  RootViewController.swift
//  appWalkthrough1
//
//  Created by Leonardo Lombardi on 9/27/16.
//  Copyright © 2016 Leonardo Lombardi. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    var pageViewController: UIPageViewController?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Configure the page view controller and add it as a child view controller.
        self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)

        let startingViewController: DataViewController = self.modelController.viewControllerAtIndex(0, storyboard: self.storyboard!)!
        let viewControllers = [startingViewController]
        self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: {done in })


        self.addChildViewController(self.pageViewController!)
        self.view.addSubview(self.pageViewController!.view)

        // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
        var pageViewRect = self.view.bounds
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            pageViewRect = CGRectInset(pageViewRect, 40.0, 40.0)
        }
        self.pageViewController!.view.frame = pageViewRect

        self.pageViewController!.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var modelController: ModelController {
        // Return the model controller object, creating it if necessary.
        // In more complex implementations, the model controller may be passed to the view controller.
        if _modelController == nil {
            _modelController = ModelController()
        }
        return _modelController!
    }

    var _modelController: ModelController? = nil
    
    
    
    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> DataViewController? {
        // Return the data view controller for the given index.
        if (modelController.pageData.count == 0) || (index >= modelController.pageData.count) {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let dataViewController = storyboard.instantiateViewControllerWithIdentifier("DataViewController") as! DataViewController
        dataViewController.dataObject = modelController.pageData[index]
        return dataViewController
    }
    
    func indexOfViewController(viewController: DataViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        return modelController.pageData.indexOf(viewController.dataObject) ?? NSNotFound
    }
    
    // Manually programatically change the page
    func changePage(direction: UIPageViewControllerNavigationDirection, controller: DataViewController) {
        var pageIndex = indexOfViewController(controller)
        if direction == .Forward {
            if pageIndex == modelController.pageData.count {
                return
            }
            pageIndex += 1
        }
        else {
            if (pageIndex == 0) || (pageIndex == NSNotFound) {
                return
            }
            pageIndex -= 1
        }
        let viewController = self.viewControllerAtIndex(pageIndex, storyboard: controller.storyboard!)
        if viewController == nil {
            return
        }
        modelController.currentIndex = pageIndex
        pageViewController!.setViewControllers([viewController!], direction: direction, animated: true, completion: { _ in })
    }

}

