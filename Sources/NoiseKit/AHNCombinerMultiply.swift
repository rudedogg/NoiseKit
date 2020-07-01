import Metal
import simd

/**
 Combines two input `AHNTextureProvider`s by multiplying their colour values with one another. The result is at least as dark as the two inputs.

 For example a pixel with a noise value of `0.3` when multiplied by another pixel with a noise value of `0.6` will result in a noise value of `0.18`.

 The multiplication is done separately for each colour channel, so the result does not default to greyscale.
 */
open class AHNCombinerMultiply: AHNCombiner {
  // MARK: - Initialiser

  public required init() {
    super.init(functionName: "multiplyCombiner")
  }
}
