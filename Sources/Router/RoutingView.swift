import SwiftUI

public struct RoutingView<C: View, D: RoutableDestination>: View {
    @State private var router = Router<D>()
    private let content: (Router<D>) -> C

    public init(@ViewBuilder content: @escaping (Router<D>) -> C) {
        self.content = content
    }

    public var body: some View {
        NavigationStack(path: $router.path) {
            content(router)
                .navigationDestination(for: D.self) {
                    router.content(destination: $0)
                }
        }
        .sheet(item: $router.presentedDestination) {
            router.content(destination: $0)
        }
    }
}
