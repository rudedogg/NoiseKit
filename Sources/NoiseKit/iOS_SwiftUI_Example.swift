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
    switch noiseType {
      case .billow:
        let noise = AHNGeneratorBillow()
        noise.octaves = Int(octaves)
        noise.frequency = frequency
        noise.persistence = persistence
        noise.lacunarity = lacunarity
        noise.seamless = true
        noise.sphereMap = true
        noise.textureWidth = 256
        noise.textureHeight = 256
        return noise.uiImage()
      case .checker:
        let noise = AHNGeneratorChecker()
        noise.frequency = frequency
        noise.textureWidth = 256
        noise.textureHeight = 256
        return noise.uiImage()
      case .cylinder:
        let noise = AHNGeneratorCylinder()
        noise.frequency = frequency
        noise.textureWidth = 256
        noise.textureHeight = 256
        return noise.uiImage()
      case .gradientBox:
        let noise = AHNGeneratorGradientBox()
        noise.textureWidth = 256
        noise.textureHeight = 256
        return noise.uiImage()
      case .ridgedMulti:
        let noise = AHNGeneratorRidgedMulti()
        noise.octaves = Int(octaves)
        noise.frequency = frequency
        noise.persistence = persistence
        noise.lacunarity = lacunarity
        noise.seamless = true
        noise.textureWidth = 256
        noise.textureHeight = 256
        return noise.uiImage()
      case .simplex:
        let noise = AHNGeneratorSimplex()
        noise.octaves = Int(octaves)
        noise.frequency = frequency
        noise.persistence = persistence
        noise.lacunarity = lacunarity
        noise.seamless = true
        noise.textureWidth = 256
        noise.textureHeight = 256
        return noise.uiImage()
      case .voronoi:
        let noise = AHNGeneratorVoronoi()
        noise.octaves = Int(octaves)
        noise.frequency = frequency
        noise.persistence = persistence
        noise.lacunarity = lacunarity
        noise.seamless = true
        noise.textureWidth = 256
        noise.textureHeight = 256
        return noise.uiImage()
      case .wave:
        let noise = AHNGeneratorWave()
        noise.frequency = frequency
        noise.textureWidth = 256
        noise.textureHeight = 256
        return noise.uiImage()
        
    }
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
