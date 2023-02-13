/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import Foundation

final class CarouselPageViewController: UIPageViewController {
    
    private var pages = [UIViewController]()
    weak var carouselDelegate: BPKCarouselDelegate?
    var currentIndex: Int {
        guard
            let viewController = viewControllers?.first,
            let index = pages.firstIndex(of: viewController)
        else { return 0 }
        return index
    }
    
    override init(
        transitionStyle style: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation,
        options: [UIPageViewController.OptionsKey: Any]? = nil
    ) {
        super.init(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil
        )
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
    }
    
    func set(images: [UIView], animated: Bool = true) {
        pages.removeAll()
        
        images.forEach {
            let contentController = CarouselContentViewController()
            pages.append(contentController)
            contentController.render(view: $0)
        }
        setCurrentImage(index: 0, animated: animated)
    }
    
    func setCurrentImage(index: Int, animated: Bool = true) {
        let availableRange = 0...(pages.count - 1)
        guard availableRange.contains(index) else { return }
        setViewControllers(
            [pages[index]],
            direction: .forward,
            animated: animated,
            completion: nil
        )
        carouselDelegate?.onImageChange(index: index)
    }
}

extension CarouselPageViewController: UIPageViewControllerDataSource {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard
            let viewControllerIndex = pages.firstIndex(of: viewController),
            pages.count > 1
        else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return pages.last }
        guard pages.count > previousIndex else { return nil }
        return pages[previousIndex]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard
            let viewControllerIndex = pages.firstIndex(of: viewController),
            pages.count > 1
        else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else { return pages.first }
        guard pages.count > nextIndex else { return nil }
        return pages[nextIndex]
    }
}

extension CarouselPageViewController: UIPageViewControllerDelegate {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        guard
            let viewController = pageViewController.viewControllers?.first,
            let index = pages.firstIndex(of: viewController)
        else { return }
        carouselDelegate?.onImageChange(index: index)
    }
}
