<p align="center">
<img src="https://raw.githubusercontent.com/smartclick/NSFW/main/WebResources/SmartClick.png" alt="Smartclick" title="Smartclick" width="557"/>
</p>

<p align="center">
<a href="https://cocoapods.org/pods/NSFW"><img src="https://img.shields.io/cocoapods/v/NSFW.svg?style=flat"></a>
<a href="https://github.com/Carthage/Carthage/"><img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat"></a>
<a href="https://swift.org/package-manager/"><img src="https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat"></a>
<br />
<a href="https://raw.githubusercontent.com/smartclick/NSFW/master/LICENSE"><img src="https://img.shields.io/cocoapods/l/Kingfisher.svg?style=flat"></a>
<a href="https://smartclick.ai/api/nsfw-detection/"><img src="https://img.shields.io/cocoapods/p/NSFW.svg?style=flat"></a>
</p>

# NSFW

## Features

- [x] Scanning image for Nudity(Hentai, Sexy, Pornographic)
- [x] Scanning image for Drawing and Neutral


## Usage

```swift
let detector = Detectror()
detector.scan(image: image) { result in    
    switch result {    
    case .success(let successResult):
        print(successResult.neutral)
        print(successResult.drawing)
        print(successResult.hentai)
        print(successResult.sexy)
        print(successResult.pornagraphic)                
    case .error(let error):
        print("Processing failed: \(error.localizedDescription)")
    }
}
```

## Requirements

- iOS 13.0+ (if you use only UIKit)
- Swift 4.2+

### Installation

#### Swift Package Manager

- File > Swift Packages > Add Package Dependency
- Add `https://github.com/smartclick/NSFW.git`

#### CocoaPods

```ruby
pod 'NSFW'
```

#### Carthage

```
github "smartclick/NSFW" ~> 7.0
```
