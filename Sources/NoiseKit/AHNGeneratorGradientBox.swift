import Metal
import simd

/// Generates a box gradient texture comprising four linear gradients originating from the four texture edges.
///
/// *Conforms to the `AHNTextureProvider` protocol.*
open class AHNGeneratorGradientBox: AHNGenerator {
  // MARK: - Properties

  /// The falloff of the gradients originating from the left and right hand texture edges. The default value of `0.0` results in the horizontal gradients terminating at the centre of the texture, higher values cause the gradient to terminate closer to its originating edge.
  open var xFallOff: Float = 0 {
    didSet {
      dirty = true
    }
  }

  /// The falloff of the gradients originating from the top and bottom texture edges. The default value of `0.0` results in the vertical gradients terminating at the centre of the texture, higher values cause the gradient to terminate closer to its originating edge.
  open var yFallOff: Float = 0 {
    didSet {
      dirty = true
    }
  }

  // MARK: - Initialiser

  public required init() {
    super.init(functionName: "boxGradientGenerator")
  }

  // MARK: - Argument table update

  /// Encodes the required uniform values for this `AHNGenerator` subclass. This should never be called directly.
  override open func configureArgumentTableWithCommandencoder(_ commandEncoder: MTLComputeCommandEncoder) {
    var uniforms = GradientInputs(positions: vector_float4(xFallOff, yFallOff, 0, 0), offsetStrength: offsetStrength, rotations: vector_float3(xRotation, yRotation, zRotation))

    if uniformBuffer == nil {
      uniformBuffer = context.device.makeBuffer(length: MemoryLayout<GradientInputs>.stride, options: .storageModeShared)
    }

    memcpy(uniformBuffer!.contents(), &uniforms, MemoryLayout<GradientInputs>.stride)

    commandEncoder.setBuffer(uniformBuffer, offset: 0, index: 0)
  }
}
