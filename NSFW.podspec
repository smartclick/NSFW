Pod::Spec.new do |spec|
  spec.name         = "NSFW"
  spec.version      = "0.0.4"
  spec.summary      = "The NSFW detector automatically identifies any inappropriate content in images."

  spec.description  = <<-DESC
Our adult content detection technology scans images and filters out any offensive content that can be considered not suitable or safe for work. The AI-powered NSFW detector recognizes offensive content in real time and helps keep the websites safe and free from improper content.
                   DESC

  spec.homepage     = "https://github.com/smartclick/NSFW"

  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = { "Sevak Soghoyan" => "sevak.soghoyan@smartclick.ai" }
  spec.social_media_url   = "https://smartclick.ai"

  spec.ios.deployment_target = "13.0"
  spec.swift_version = "4.2"

  spec.source       = { :git => "https://github.com/smartclick/NSFW.git", :tag => "#{spec.version}" }
  spec.source_files  = ["Sources/**/*.swift"]

end
