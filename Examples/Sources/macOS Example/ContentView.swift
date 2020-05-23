import SwiftUI
import NoiseKit

struct ContentView: View {
  var image = NSImage {
    let simplex = AHNGeneratorSimplex()
    
  }()
  var body: some View {
    Text("Hello, World!")
      .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
