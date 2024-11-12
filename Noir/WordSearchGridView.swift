import SwiftUI

struct WordSearchGridWindow: View {
    @StateObject private var controller = WordSearchController()
    var body: some View {
        ZStack {
            WordSearchView()
                .environmentObject(controller)
        }
    }
}

#Preview(windowStyle: .volumetric) {
    WordSearchGridWindow()
}
