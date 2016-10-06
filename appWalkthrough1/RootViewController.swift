//
//  RootViewController.swift
//  appWalkthrough1
//
//  Created by Leonardo Lombardi on 9/27/16.
//  Copyright © 2016 Leonardo Lombardi. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UIPageViewControllerDelegate {

    var pageViewController: UIPageViewController?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Configure the page view controller and add it as a child view controller.
        self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        self.pageViewController!.delegate = self

        let startingViewController: DataViewController = self.modelController.viewControllerAtIndex(0, storyboard: self.storyboard!)!
        let viewControllers = [startingViewController]
        self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: {done in })

        self.pageViewController!.dataSource = self.modelController

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

    // MARK: - UIPageViewController delegate methods

//    func pageViewController(pageViewController: UIPageViewController, spineLocationForInterfaceOrientation orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
//        if (orientation == .Portrait) || (orientation == .PortraitUpsideDown) || (UIDevice.currentDevice().userInterfaceIdiom == .Phone) {
//            // In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to true, so set it to false here.
//            let currentViewController = self.pageViewController!.viewControllers![0]
//            let viewControllers = [currentViewController]
//            self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: {done in })
//
//            self.pageViewController!.doubleSided = false
//            return .Min
//        }
//
//        // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
//        let currentViewController = self.pageViewController!.viewControllers![0] as! DataViewController
//        var viewControllers: [UIViewController]
//
//        let indexOfCurrentViewController = self.modelController.indexOfViewController(currentViewController)
//        if (indexOfCurrentViewController == 0) || (indexOfCurrentViewController % 2 == 0) {
//            let nextViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerAfterViewController: currentViewController)
//            viewControllers = [currentViewController, nextViewController!]
//        } else {
//            let previousViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerBeforeViewController: currentViewController)
//            viewControllers = [previousViewController!, currentViewController]
//        }
//        self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: {done in })
//
//        return .Mid
//    }


}

