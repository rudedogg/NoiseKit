import SwiftUI

public struct SwiftUIView: View {
  var noiseImage: UIImage = {
    let noiseImage = AHNGeneratorSimplex().uiImage() ?? UIImage(named: "circle")!
    return noiseImage
  }()

//  var noiseImage: UIImage = {
//    let noiseImage = AHNGeneratorSimplex().uiImage()!
//    return noiseImage
//  }()
  public var body: some View {
    SwiftUI.Image(uiImage: noiseImage)
//      Text("Hi").onAppear {
//      }
  }
}

struct SwiftUIView_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUIView()
  }
}
