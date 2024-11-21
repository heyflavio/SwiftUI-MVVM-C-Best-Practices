import SwiftUI

struct ThirdView: View {
    let viewModel: ThirdViewModel<SecondComponentCoordinator>
    
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
        // Navigation - at least one should be implemented
//        .navigationDestination(for: ThirdRoute.self) { destination in
//            self.viewModel.destinationContent(for: destination)
//        }
//        .sheet(isPresented: self.$showSheet) {
//            self.viewModel.bottomSheetContent()
//        }
//        .fullScreenCover(isPresented: self.$showfullScreenCover) {
//            self.viewModel.fullScreenContent()
//        }
    }
}
