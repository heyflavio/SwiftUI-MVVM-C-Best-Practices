import SwiftUI

struct FirstView: View {
    let viewModel: FirstViewModel<FirstComponentCoordinator>
    
    @State private var displayedValue = ""
    @State private var showSheet = false
    @State private var showfullScreenCover = false

    var body: some View {
        VStack {
            Text(self.displayedValue)
            
            Button(action: {
                self.viewModel.inputs.inputSubject.send()
            }) {
                Text("Tap Me")
            }
            
            Button("Next Screen") {
                self.viewModel.inputs.navigateSubject.send()
            }
        }
        // Outputs
        .bindPublisher(self.viewModel.outputs.outputSubject, to: self.$displayedValue)
        .bindPublisher(self.viewModel.outputs.showModalView, to: self.$showSheet)
        // Navigation handler
        .handleNavigation(
            viewModel: self.viewModel,
            showSheet: self.$showSheet,
            showFullScreenCover: self.$showfullScreenCover
        )

    }
}

// Handle Navigation
private extension View {
    
    func handleNavigation(
        viewModel: FirstViewModel<FirstComponentCoordinator>,
        showSheet: Binding<Bool>,
        showFullScreenCover: Binding<Bool>
    ) -> some View {
        self
            .navigationDestination(for: FirstComponentCoordinator.Route.self) { destination in
                viewModel.destinationContent(for: destination)
            }
            .sheet(isPresented: showSheet) {
                viewModel.bottomSheetContent()
            }
            .fullScreenCover(isPresented: showFullScreenCover) {
                viewModel.fullScreenContent()
            }
    }
    
}

struct FirstViewPreviews: PreviewProvider {
    static var previews: some View {
        FirstView(
            viewModel: .init(
                dependencies: .init(
                    coordinator: .init(
                        appCoordinator: AppCoordinator()))))
            .previewLayout(.sizeThatFits) // Optional: Adjust layout for the preview
    }
}
