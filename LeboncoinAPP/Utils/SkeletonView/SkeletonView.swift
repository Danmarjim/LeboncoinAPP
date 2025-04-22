import SwiftUI

struct SkeletonView<S: Shape>: View {
  @State private var isAnimating: Bool = false
  private var shape: S
  
  private var rotation: Double {
    return 5
  }
  
  private var animation: Animation {
    .easeInOut(duration: 1.5).repeatForever(autoreverses: false)
  }
  
  init(_ shape: S) {
    self.shape = shape
  }
  
  var body: some View {
    shape
      .fill(.gray.opacity(0.2))
      .overlay {
        GeometryReader {
          let size = $0.size
          let skeletonWidth = size.width / 2
          
          let blurRadius = max(skeletonWidth / 2, 30)
          let blurDiameter = blurRadius * 2
          
          let minX = -(skeletonWidth + blurDiameter)
          let maxX = size.width + skeletonWidth + blurDiameter
          
          Rectangle()
            .fill(.gray)
            .frame(width: skeletonWidth, height: size.height * 2)
            .frame(height: size.height)
            .blur(radius: blurRadius)
            .rotationEffect(.init(degrees: rotation))
            .blendMode(.softLight)
          
            .offset(x: isAnimating ? maxX : minX)
        }
      }
      .clipShape(shape)
      .compositingGroup()
      .onAppear {
        guard !isAnimating else { return }
        withAnimation(animation) {
          isAnimating = true
        }
      }
      .onDisappear {
        isAnimating = false
      }
  }
}

#Preview {
  SkeletonView(.circle)
    .frame(width: 100, height: 100)
}
