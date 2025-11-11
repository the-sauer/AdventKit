//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0/.
//
//  Copyright 2025 Hendrik Sauer

// swiftlint:disable identifier_name

import CoreGraphics

struct Point2D {
    var x: Double
    var y: Double

    var asCGPoint: CGPoint {
        CGPoint(x: CGFloat(x), y: CGFloat(y))
    }

    static func + (lhs: Self, rhs: Vector2D) -> Self {
        Self(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    static func * (lhs: Self, rhs: CGSize) -> Self {
        Self(x: lhs.x * rhs.width, y: lhs.y * rhs.height)
    }
}

struct Vector2D {
    let x: Double
    let y: Double

    static func * (lhs: Self, rhs: Double) -> Self {
        Self(x: lhs.x + rhs, y: lhs.y + rhs)
    }
}

struct Point3D {
    var x: Double
    var y: Double
    var z: Double

    var xy: Point2D {
        Point2D(x: x, y: y)
    }

    static func + (lhs: Self, rhs: Vector3D) -> Self {
        Self(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }
}

struct Vector3D {
    let x: Double
    let y: Double
    let z: Double

    var xy: Point2D {
        Point2D(x: x, y: y)
    }

    static func + (lhs: Self, rhs: Vector3D) -> Self {
        Self(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }

    static func * (lhs: Self, rhs: Double) -> Self {
        Self(x: lhs.x * rhs, y: lhs.y * rhs, z: lhs.z * rhs)
    }
}

// swiftlint:enable identifier_name
