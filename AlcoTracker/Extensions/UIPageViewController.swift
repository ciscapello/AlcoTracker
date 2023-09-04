//
//  UIPageViewController.swift
//  AlcoTracker
//
//  Created by Владимир on 03.09.2023.
//

import UIKit

extension UIPageViewController {
    func goToNextPage(animated: Bool = true, pageControl: UIPageControl, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        pageControl.currentPage = pageControl.currentPage + 1
        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }
}
