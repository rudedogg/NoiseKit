import Metal
import simd

/**
 Combines two input `AHNTextureProvider`s by subtracting their colour values from one another.

 The value of the output is calculated using: `output = input1.rgb - input2.rgb`.

 For example a pixel with a noise value of `0.3` when subtracted from another pixel with a noise value of `0.6` will result in a noise value of `0.3`.

 Resultant values lower than `0.0` will show as black. The subtraction is done separately for each colour channel, so the result does not default to greyscale.
 */
open class AHNCombinerSubtract: AHNCombiner {
  // MARK: - Initialiser

  public required init() {
    super.init(functionName: "subtractCombiner")
  }
}
