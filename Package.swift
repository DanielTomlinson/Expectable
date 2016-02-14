import PackageDescription

let package = Package(name: "Expectable",
                      dependencies: [
                        .Package(url: "https://github.com/endocrimes/FailureType.git", majorVersion: 0)
                      ])
