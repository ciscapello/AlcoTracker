//
//  OnboardingPageViewController.swift
//  AlcoTracker
//
//  Created by Владимир on 03.09.2023.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {
    var pages = [UIViewController]()
    var pageControl = UIPageControl()
    let initialPage = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        dataSource = self
        delegate = self
        let firstPage = OnboardingPageContentViewController()
        firstPage.configure(title: "Добро пожаловать, дорогой друг",
                            label: "Это приложение поможет тебе узнать себя чуточку получше",
                            image: R.image.onboarding1.name)
        let secondPage = OnboardingPageContentViewController()
        secondPage.configure(title: "Возможности",
                             label: "Ты сможешь подбивать статистику по каждому походу в бар, по каждой выпитой бутылочке пива после работы, по каждому бокалу вина в компании друзей",
                             image: R.image.onboarding2.name)
        let thirdPage = OnboardingPageContentViewController()
        thirdPage.configure(title: "Что дальше",
                            label: "Анализируя опыт своих пьянок ты либо станешь меньше пить, либо поймешь насколько это глубокая часть тебя, но суть в том, что только посредством анализа у тебя получится осознать все плюсы и минусы алкоголизма",
                            image: R.image.onboarding3.name)
        pages.append(firstPage)
        pages.append(secondPage)
        pages.append(thirdPage)
        setViewControllers([pages[initialPage]], direction: .forward, animated: true)
        view.addSubview(pageControl)

        pageControl.snp.makeConstraints { make in
            make.right.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(60)
        }

        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage

        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
    }

    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
}

extension OnboardingPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        if currentIndex == 0 {
            return nil
        } else {
            return pages[currentIndex - 1]
        }
    }

    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return nil
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating _: Bool, previousViewControllers _: [UIViewController], transitionCompleted _: Bool) {
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }

        pageControl.currentPage = currentIndex
    }
}
