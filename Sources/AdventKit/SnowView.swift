//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0/.
//
//  Copyright 2025 Hendrik Sauer

import SwiftUI

struct Snowflake: Identifiable {
    let id = UUID()
    var pos: Point3D
    var velocity: Vector3D
}

@available(macOS 14.0, *)
@available(iOS 17.0, *)
public struct SnowView: View {
    /// The minimum amount of snowflakes for intensity 0.
    let minFlakeCount: Int = 6

    /// The maximum amount of snowflakes for intensity 1.
    let maxFlakeCount: Int = 400

    /// The size of a most near snowflake (`z=1`).
    let nearSize: Double = 4
    /// The size of a most far snowflake (`z=0`).
    let farSize: Double = 1
    /// The opacity of a most near snowflake (`z=1`).
    let nearOpacity: Double = 0.9
    /// The opacity of a most far snowflake (`z=0`).
    let farOpacity: Double = 0.3

    /// Die Farbe der Schneeflocken.
    let flakeColor: Color = .init(red: 1, green: 1, blue: 1)

    let baseVelocity: Vector3D

    init(intensity: Double, baseVelocity: Vector3D = .init(x: 0, y: 0.002, z: 0)) {
        let clampedIntensity: Double = max(min(intensity, 1), 0)
        self.baseVelocity = baseVelocity
        let totalFlakes = Int(Double(minFlakeCount) + Double(maxFlakeCount - minFlakeCount) * clampedIntensity)
        self.snowflakes = (0..<totalFlakes).map { _ in
            Snowflake(
                pos: .init(x: .random(in: 0...1), y: .random(in: 0...1), z: .random(in: 0...1)),
                velocity: baseVelocity
            )
        }
    }

    @State private var snowflakes: [Snowflake]

    public var body: some View {
        TimelineView(.animation) { context in
            Canvas { gContext, size in
                for flake in snowflakes {
                    let flakeSize = farSize + flake.pos.z * (nearSize - farSize)
                    let opacity = farOpacity + flake.pos.z * (nearOpacity - farOpacity)
                    let rect = CGRect(
                        origin: (flake.pos.xy * size).asCGPoint,
                        size: CGSize(width: flakeSize, height: flakeSize)
                    )
                    gContext.opacity = opacity
                    gContext.fill(Path(ellipseIn: rect), with: .color(flakeColor))
                }
            }
            .onChange(of: context.date) { _, _ in
                updateSnowflakes()
            }
        }
        .ignoresSafeArea()
    }

    private func updateSnowflakes() {
        for index in 0..<snowflakes.count {
            snowflakes[index].pos = snowflakes[index].pos + snowflakes[index].velocity  // swiftlint:disable:this shorthand_operator
            if snowflakes[index].pos.y > 1 {
                snowflakes[index].pos = .init(x: .random(in: 0...1), y: 0, z: .random(in: 0...1))
                snowflakes[index].velocity = baseVelocity
            }
            snowflakes[index].velocity = snowflakes[index].velocity + .init(    // swiftlint:disable:this shorthand_operator
                x: .random(in: -0.0001...0.0001),
                y: .random(in: -0.00001...0.00002),
                z: .random(in: -0.0001...0.0001)
            )
        }
    }
}

#Preview {
    if #available(macOS 14.0, *), #available(iOS 17.0, *) {
        SnowView(intensity: 0.8)
            .background {
                Color.black
            }
            .ignoresSafeArea()
    }
}
