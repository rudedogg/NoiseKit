import SwiftUI

struct DetailedSlider<V>: View where V: BinaryFloatingPoint, V.Stride: BinaryFloatingPoint {
  @Binding var value: V
  var bounds: ClosedRange<V>
  var label: String

  private let defaultFormatter: Formatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2
    return formatter
  }()

  var body: some View {
    HStack {
      HStack {
        Text("\(label)")
        Spacer()
      }
      .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
      .frame(width: 130.0)
      Slider(value: $value, in: 0...100.0)
      Text("\(defaultFormatter.string(for: self.value) ?? "#ERROR#")")
        .font(.system(.caption, design: .monospaced))
    }
  }
}

struct SwiftUIView_Previews: PreviewProvider {
  static var previews: some View {
    DetailedSlider(value: .constant(5.0), bounds: 0...10, label: "Test")
  }
}
