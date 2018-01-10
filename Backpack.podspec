#
# Be sure to run `pod lib lint Backpack.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Backpack'
  s.version          = '0.0.1'
  s.summary          = "Skyscanner's Design System Backpack for iOS"

  s.description      = <<-DESC
  The Skyscanner Design System, Backpack, for iOS apps
                       DESC

  s.homepage         = 'https://github.com/Skyscanner/backpack-ios'
  s.license          = { type: 'Apache-2.0', file: 'LICENSE' }
  s.author           = {
    'Hugo Tunius' => 'hugo.tunius@skyscanner.net'
  }
  s.source = {
    git: 'git@github.com:Skyscanner/backpack-ios.git', tag: s.version.to_s
  }
  s.ios.deployment_target = '9.0'

  s.source_files = 'Backpack/Classes/**/*'
end
