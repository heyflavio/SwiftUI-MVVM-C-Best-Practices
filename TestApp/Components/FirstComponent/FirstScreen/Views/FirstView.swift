import SwiftUI

struct FirstView: View {
    @ObservedObject var viewModel: FirstViewModel<FirstComponentCoordinator>
    
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
        .onReceive(self.viewModel.outputs.outputSubject) { newValue in
            self.displayedValue = newValue // Update the displayed value when the subject emits a new value
        }
        .onReceive(self.viewModel.outputs.showModalView) { newValue in
            self.showSheet = newValue
        }
        // Navigation - at least one should be implemented
        .navigationDestination(
            for: FirstComponentCoordinator.Route.self
        ) { destination in
            self.viewModel.destinationContent(for: destination)
        }
//        .sheet(isPresented: self.$showSheet) {
//            self.viewModel.bottomSheetContent()
//        }
//        .fullScreenCover(isPresented: self.$showfullScreenCover) {
//            self.viewModel.fullScreenContent()
//        }
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
