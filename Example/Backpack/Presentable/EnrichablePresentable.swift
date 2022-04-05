extension Presentable {
    /**
     * Add an enrichment step to the presentable.
     *
     * parameter map: The function to apply to the result before returning the view controller.
     * returns: A new Presentable containing the enrichement.
    */
    func enrich(_ map: @escaping (UIViewController) -> Void) -> Presentable {
        return EnrichedPresentable(inner: self, closure: map)
    }
}

struct EnrichedPresentable {
    let inner: Presentable
    let closure: (UIViewController) -> Void
}

extension EnrichedPresentable: Presentable {
    func makeViewController() -> UIViewController {
        let innerVc = inner.makeViewController()
        closure(innerVc)

        return innerVc
    }
}
