Pod::Spec.new do |spec|
  spec.name         = "NSFW"
  spec.version      = "0.0.4"
  spec.summary      = "A Cocoapods library for checking NSFW in Images"

  spec.description  = <<-DESC
Our adult content detection technology can recognize any not-safe-for-work (NSFW) content in an image.
                   DESC

  spec.homepage     = "https://github.com/smartclick/NSFW"

  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = { "Sevak Soghoyan" => "sevak.soghoyan@smartclick.ai" }
  spec.social_media_url   = "https://smartclick.ai"

  spec.ios.deployment_target = "13.0"
  spec.swift_version = "4.2"

  spec.source       = { :git => "https://github.com/smartclick/NSFW.git", :tag => "#{spec.version}" }
  spec.source_files  = "NSFW", "NSFW/**/*.{h,m}"

end
