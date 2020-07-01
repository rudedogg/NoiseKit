#if os(macOS)
  import AppKit
  public typealias Color = NSColor
  public typealias Image = NSImage
//  public typealias Size = NSSize
#else
  import UIKit
  public typealias Color = UIColor
  public typealias Image = UIImage
  // public typealias Size = CGSize
#endif

// #if os(macOS)
// import AppKit
// typealias Image = NSImage
// #elseif os(iOS) || os(tvOS) || os(watchOS)
// import UIKit
// typealias Image = UIImage
// #endif

extension Image {
  /// Converts the input `MTLTexture` into a UIImage.
  static func imageWithMTLTexture(_ texture: MTLTexture) -> Image {
    assert(texture.pixelFormat == .rgba8Unorm, "Pixel format of texture must be MTLPixelFormatBGRA8Unorm to create UIImage")

    let imageByteCount: size_t = texture.width * texture.height * 4
    let imageBytes = malloc(imageByteCount)
    let bytesPerRow = texture.width * 4

    let region = MTLRegionMake2D(0, 0, texture.width, texture.height)
    texture.getBytes(imageBytes!, bytesPerRow: bytesPerRow, from: region, mipmapLevel: 0)

    let AHNReleaseDataCallback: CGDataProviderReleaseDataCallback = { (_: UnsafeMutableRawPointer?, data: UnsafeRawPointer, _: Int) -> Void in
      free(UnsafeMutableRawPointer(mutating: data))
    }

    guard let provider = CGDataProvider(dataInfo: nil, data: imageBytes!, size: imageByteCount, releaseData: AHNReleaseDataCallback) else {
      fatalError("AHNoise: Error creating CGDataProvider for conversion of MTLTexture to UIImage")
    }
    let bitsPerComponent = 8
    let bitsPerPixel = 32
    let colourSpaceRef = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo: CGBitmapInfo = [CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue), CGBitmapInfo.byteOrder32Big]
    let renderingIntent: CGColorRenderingIntent = .defaultIntent

    let imageRef = CGImage(
      width: texture.width,
      height: texture.height,
      bitsPerComponent: bitsPerComponent,
      bitsPerPixel: bitsPerPixel,
      bytesPerRow: bytesPerRow,
      space: colourSpaceRef,
      bitmapInfo: bitmapInfo,
      provider: provider,
      decode: nil,
      shouldInterpolate: false,
      intent: renderingIntent
    )

    #if os(macOS)
      let image = Image(cgImage: imageRef!, size: CGSize(width: texture.width, height: texture.height))
    #elseif os(iOS) || os(tvOS) || os(watchOS)
      let image = Image(cgImage: imageRef!, scale: 0.0, orientation: Image.Orientation.downMirrored)
    #endif
    return image
  }
}
