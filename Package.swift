
 // swift-tools-version:5.2
 // The swift-tools-version declares the minimum version of Swift required to build this package.
 import PackageDescription

 let package = Package(
     name: "ALFormInput",
     platforms: [.iOS(.v9)],
     products: [
         .library(
             name: "ALFormInput",
             targets: ["ALFormInput"]),
     ],
     targets: [
         .target(
             name: "ALFormInput",
             dependencies: [],
             path: "ALFormInput")
     ]
 )
