import SwiftUI

enum NoiseType: String, CaseIterable {
  case billow = "Billow"
  case checker = "Checker"
  case cylinder = "Cylinder"
  case gradientBox = "Gradient Box"
  case ridgedMulti = "Ridged Multi"
  case simplex = "Simplex"
  case voronoi = "Voronoi"
  case wave = "Wave"
}

struct NoiseKitSwiftUIExampleView: View {
  @State var noiseType: NoiseType = .voronoi
  @State var octaves: Float = 1.0
  @State var frequency: Float = 1.0
  @State var persistence: Float = 1.0
  @State var lacunarity: Float = 1.0
  
  private func getNoiseImage() -> UIImage? {
    var noise: AHNGenerator
    
    switch noiseType {
      case .billow:
        noise = AHNGeneratorBillow()
      case .checker:
        noise = AHNGeneratorChecker()
      case .cylinder:
        noise = AHNGeneratorCylinder()
      case .gradientBox:
        noise = AHNGeneratorGradientBox()
      case .ridgedMulti:
        noise = AHNGeneratorRidgedMulti()
      case .simplex:
        noise = AHNGeneratorSimplex()
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
      coherentNoise.seamless = true
      coherentNoise.sphereMap = true
      return coherentNoise.uiImage()
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
        VStack {
          Text("Frequency:")
          Slider(value: $frequency, in: 0...100.0, label: { Text("Frequency: ") })
        }
        Slider(value: $octaves, in: 0...10, step: 1.0, label: { Text("Octaves: ")} )
      Slider(value: $persistence, in: 0...10, minimumValueLabel: Text("0"), maximumValueLabel: Text("10"), label: { Text("Persistence: ")} )
      Slider(value: $lacunarity, in: 0...10, minimumValueLabel: Text("0"), maximumValueLabel: Text("10"), label: { Text("Lacunarity: ")} )
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
