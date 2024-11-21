import SwiftUI

struct SecondView: View {
    let viewModel: SecondViewModel<SecondComponentCoordinator>
    
    @State private var displayedValue = ""
    @State private var showSheet = false
    @State private var showfullScreenCover = false

    var body: some View {
        VStack {
            Text(self.displayedValue)
            
            Button(action: {
                self.viewModel.inputs.inputSubject.send()
            }) {
                Text("Tap Me Again")
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
        viewModel: SecondViewModel<SecondComponentCoordinator>,
        showSheet: Binding<Bool>,
        showFullScreenCover: Binding<Bool>
    ) -> some View {
        self
            .navigationDestination(for: SecondComponentCoordinator.Route.self) { destination in
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
