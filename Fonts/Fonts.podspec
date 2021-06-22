#
#  Be sure to run `pod spec lint Fonts.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "Fonts"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of Fonts."
  spec.description      = <<-DESC
  A local pod that can optionaly contain Skyscanner fonts to include in the bundle.
                       DESC
  spec.homepage         = 'https://github.com/Skyscanner/backpack-ios'
  spec.license          = { type: 'Apache-2.0', file: 'LICENSE' }
  spec.author           = {
    'Backpack Design System' => 'backpack@skyscanner.net'
  }
  spec.source = {
    git: 'https://github.com/Skyscanner/backpack-ios.git', tag: spec.version.to_s
  }
  spec.resources = 'Assets/**/*.ttf'
  spec.prepare_command = 'Scripts/download-relative-fonts'

end
