import SwiftUI
import NoiseKit

struct NoiseKitSwiftUIExampleView: View {
  @State var noiseType: NoiseType = .voronoi
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
    
    noise.textureWidth = 256
    noise.textureHeight = 256
    
    if let coherentNoise = noise as? AHNGeneratorCoherent {
      coherentNoise.octaves = Int(octaves)
      coherentNoise.frequency = frequency
      coherentNoise.persistence = persistence
      coherentNoise.lacunarity = lacunarity
      coherentNoise.seamless = seamless
      coherentNoise.sphereMap = sphereMap
    }
    
    if let cylinderNoise = noise as? AHNGeneratorCylinder {
      cylinderNoise.frequency = frequency
    }
    
    if let gradientBoxNoise = noise as? AHNGeneratorGradientBox {
      gradientBoxNoise.xFallOff = xFallOff
      gradientBoxNoise.yFallOff = yFallOff
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
