import Metal
import simd

/**
 Combines two input `AHNTextureProvider`s by choosing the minimum value of the two.

 The value of the output is calculated by first calculating the average value of the three colour channels, then selecting the minimum value and writing the three channels to the output in order to retain colour.

 For example a pixel with a noise value of `0.3` when compared with another pixel with a noise value of `0.6` will result in a noise value of `0.3`.
 */
open class AHNCombinerMin: AHNCombiner {
  // MARK: - Initialiser

  public required init() {
    super.init(functionName: "minCombiner")
  }
}
