import SwiftUI

public struct NoiseKitSwiftUIExampleView: View {
  @State var wValue: Float = 0.0
  var noiseImage: UIImage? = {
    let noise = AHNGeneratorSimplex()
//    noise.wValue = wValue
    noise.seamless = true
    noise.textureWidth = 256
    noise.textureHeight = 256
    return noise.uiImage()
  }()
  
  public var body: some View {
    HStack {
      Image(uiImage: noiseImage!)
        .resizable(capInsets: EdgeInsets(), resizingMode: .tile)
    }
    .padding(.all)
  }
}

struct NoiseKitSwiftUIExampleView_Previews: PreviewProvider {
  static var previews: some View {
    NoiseKitSwiftUIExampleView()
      .previewDevice("iPhone SE (2nd generation)")
  }
}
