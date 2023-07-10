// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LibraryTestSDK",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ClickmeliveiOSSDK",
            targets: ["ClickmeliveiOSSDKTarget"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/Kofktu/PIPKit.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.6.4")),
//        .package(url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.1.0"),
        .package(url: "https://github.com/daltoniam/Starscream.git", from: "4.0.0"),
        .package(url: "https://github.com/airbnb/lottie-spm.git", from: "4.2.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "LibraryTest1",
            dependencies: ["ClickmeliveiOSSDKTarget"]),
        .target(
            name: "ClickmeliveiOSSDKTarget",
            dependencies: [.target(name: "ClickmeliveiOSSDKWrapper", condition: .when(platforms: [.iOS]))],
            path: "ClickmeliveiOSSDKTarget"
        ),
        .target(
            name: "ClickmeliveiOSSDKWrapper",
            dependencies: [
                .target(name: "ClickmeliveiOSSDK", condition: .when(platforms: [.iOS])),
                .product(name: "Alamofire", package: "Alamofire"),
//                .product(name: "SDWebImage", package: "SDWebImage"),
                .product(name: "Starscream", package: "Starscream"),
                .product(name: "Lottie", package: "lottie-spm"),
                .product(name: "PIPKit", package: "PIPKit"),
                .target(name: "AmazonIVSPlayer", condition: .when(platforms: [.iOS]))
            ],
            path: "ClickmeliveiOSSDKWrapper"
        ),
        .testTarget(
            name: "LibraryTest1Tests",
            dependencies: ["LibraryTest1"]),
        .binaryTarget(name: "AmazonIVSPlayer", path: "AmazonIVSPlayer.xcframework"),
        .binaryTarget(name: "ClickmeliveiOSSDK", path: "ClickmeliveiOSSDK.xcframework")
    ]
)
