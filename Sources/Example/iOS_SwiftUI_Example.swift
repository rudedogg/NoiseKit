import NoiseKit
import SwiftUI

private struct NoiseKitSwiftUIExampleView: View {
  @State var noiseType: NoiseType = .voronoi
  @State var textureSize: Float = 256.0
  @State var octaves: Float = 1.0
  @State var frequency: Float = 1.0
  @State var persistence: Float = 1.0
  @State var lacunarity: Float = 1.0
  @State var xFallOff: Float = 1.0
  @State var yFallOff: Float = 1.0
  @State var sphereMap: Bool = false
  @State var seamless: Bool = true

  private func getNoiseImage() -> UIImage? {
    var noise: AHNGenerator

    switch noiseType {
      case .billow:
        noise = AHNGeneratorBillow()
      case .checker:
        noise = AHNGeneratorChecker()
      case .constant:
        noise = AHNGeneratorConstant()
      case .cylinder:
        noise = AHNGeneratorCylinder()
      case .gradientBox:
        noise = AHNGeneratorGradientBox()
      case .gradientLinear:
        noise = AHNGeneratorGradientLinear()
      case .gradientRadial:
        noise = AHNGeneratorGradientRadial()
      case .ridgedMulti:
        noise = AHNGeneratorRidgedMulti()
      case .simplex:
        noise = AHNGeneratorSimplex()
      case .sphere:
        noise = AHNGeneratorSphere()
      case .voronoi:
        noise = AHNGeneratorVoronoi()
      case .wave:
        noise = AHNGeneratorWave()
    }

    noise.textureWidth = Int(textureSize)
    noise.textureHeight = Int(textureSize)

    switch noise {
      case let coherentNoise as AHNGeneratorCoherent:
        coherentNoise.octaves = Int(octaves)
        coherentNoise.frequency = frequency
        coherentNoise.persistence = persistence
        coherentNoise.lacunarity = lacunarity
        coherentNoise.seamless = seamless
        coherentNoise.sphereMap = sphereMap
      case let cylinderNoise as AHNGeneratorCylinder:
        cylinderNoise.frequency = frequency
      case let gradientBoxNoise as AHNGeneratorGradientBox:
        gradientBoxNoise.xFallOff = xFallOff
        gradientBoxNoise.yFallOff = yFallOff
      default:
        break
    }

    return noise.uiImage()
  }

  var body: some View {
    VStack {
      Form {
        Picker(selection: $noiseType, label: Text("Noise Type:")) {
          ForEach(NoiseType.allCases, id: \.self) { noiseType in
            Text(noiseType.rawValue)
          }
        }
        .pickerStyle(SegmentedPickerStyle())
        Toggle("Sphere Map:", isOn: $sphereMap)
        Toggle("Seamless:", isOn: $seamless)
        DetailedSlider(value: $textureSize, bounds: 32...2048, label: "Texture Size:")
        DetailedSlider(value: $frequency, bounds: 0...100, label: "Frequency:")
        DetailedSlider(value: $octaves, bounds: 0...10, label: "Octaves:")
        DetailedSlider(value: $persistence, bounds: 0...10, label: "Persistence:")
        DetailedSlider(value: $lacunarity, bounds: 0...10, label: "Lacunarity:")
        DetailedSlider(value: $xFallOff, bounds: -10...10, label: "xFallOff:")
        DetailedSlider(value: $yFallOff, bounds: -10...10, label: "yFallOff:")
      }
      Image(uiImage: getNoiseImage()!)
        .resizable(capInsets: EdgeInsets(), resizingMode: .tile)
    }
    .padding(.all)
  }
}

struct NoiseKitSwiftUIExampleView_Previews: PreviewProvider {
  static var previews: some View {
    NoiseKitSwiftUIExampleView()
      .previewDevice("iPad Air (3rd generation)")
  }
}
