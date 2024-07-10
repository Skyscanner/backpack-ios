import UIKit
import SwiftUI

public class BPKInternalCardCarousel: UIViewController, UICollectionViewDelegate {
    private var collectionView: UICollectionView!
    private var cards: [any View] = []
    @Binding private var currentIndex: Int
    
    let multiplier = 2_000
    
    public init(cards: [any View], currentIndex: Binding<Int>) {
        self.cards = cards
        self._currentIndex = currentIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
}

extension BPKInternalCardCarousel: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count * multiplier
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)

        // Remove existing subviews to prevent stacking views on top of each other.
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
            
        let componentIndex = indexPath.item % cards.count
        guard componentIndex < cards.count else { return cell }
        
        let swiftUIView = cards[componentIndex]
        // Ideally, you should reuse UIHostingController instances here if possible.
        // For simplicity, we're creating a new one each time, but consider optimizing this.
        let hostingController = UIHostingController(rootView: AnyView(swiftUIView))

        cell.contentView.addSubview(hostingController.view)

        // Center the hostingController.view within the cell.contentView
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            hostingController.view.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            hostingController.view.widthAnchor.constraint(equalTo: cell.contentView.widthAnchor),
            hostingController.view.heightAnchor.constraint(equalTo: cell.contentView.heightAnchor)
        ])
        return cell
    }
}

extension BPKInternalCardCarousel {
    private func setupCollectionView () {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: setupLayout())
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .clear
        
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = false
        
        let middleSectionIndex = ((cards.count * multiplier) / 2) + self.currentIndex
        collectionView.scrollToItem(at: IndexPath(
            item: middleSectionIndex,
            section: 0
        ), at: .centeredHorizontally, animated: false)
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    private func setupLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] (_, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // Slightly reduce the group width to bring scaled-down cards closer
            let groupWidthFraction: CGFloat = 0.75 // Adjusted from 0.8 to 0.75
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(groupWidthFraction),
                heightDimension: .fractionalHeight(1))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            
            // Adjust contentInsets dynamically based on the new group width
            let totalInset = layoutEnvironment.container.contentSize.width * (1 - groupWidthFraction) / 2
            section.contentInsets = NSDirectionalEdgeInsets(
                top: 20,
                leading: totalInset,
                bottom: 20,
                trailing: totalInset
            )
            
            section.visibleItemsInvalidationHandler = self?.setupVisibleItemsInvalidationHandler()
            
            return section
        }
    }
    
    private func setupVisibleItemsInvalidationHandler () -> NSCollectionLayoutSectionVisibleItemsInvalidationHandler {
        return { [weak self] (items, offset, environment) in
            DispatchQueue.main.async {
                let currentPage = Int(offset.x) / Int(items.first?.bounds.width ?? 0)
                self?.currentIndex = currentPage % (self?.cards.count ?? 0)
            }

            items.forEach { item in
                let distanceFromCenter = abs(
                    (item.frame.midX - offset.x) - (environment.container.contentSize.width / 2.0)
                )
                
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
            
            let scrollOffset = offset.x
            let visibleWidth = environment.container.contentSize.width
            
            items.forEach { item in
                let itemOffset = item.frame.origin.x
                let distanceFromVisibleArea = abs(itemOffset - scrollOffset)
                let maxDistance = visibleWidth + item.frame.size.width
                if distanceFromVisibleArea > maxDistance {
                    item.transform = CGAffineTransform.identity
                }
            }
        }
    }
}
