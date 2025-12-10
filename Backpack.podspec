# Backpack - Skyscanner's Design System

# Copyright 2018 Skyscanner Ltd

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#   http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

Pod::Spec.new do |s|
  s.name             = 'Backpack'
  s.version          = ENV['LIB_VERSION'] || '1.0' # Fallback to v1
  s.summary          = "Skyscanner's Design System Backpack for iOS"

  s.description      = <<-DESC
  The Skyscanner Design System, Backpack, for iOS apps
                       DESC

  s.homepage         = 'https://github.com/Skyscanner/backpack-ios'
  s.license          = { type: 'Apache-2.0', file: 'LICENSE' }
  s.author           = {
    'Backpack Design System' => 'backpack@skyscanner.net'
  }
  s.source = {
    git: 'https://github.com/Skyscanner/backpack-ios.git', tag: s.version.to_s
  }
  s.ios.deployment_target = '16.0'
  s.source_files = 'Backpack/Backpack.h', 'Backpack/Common.h', 'Backpack/*/Classes/**/*.{h,m,swift}'
  # Exclude test files and bridge headers that just re-export Generated content
  # The bridge headers (BPK*.h at Classes level) have same basename as Generated/*.h and cause conflicts
  s.exclude_files = [
    'Backpack/Tests/**',
    'Backpack/BorderWidth/Classes/BPKBorderWidth.h',
    'Backpack/Color/Classes/BPKColor.h',
    'Backpack/Color/Classes/UIColor+Backpack.h',
    'Backpack/Duration/Classes/BPKDuration.h',
    'Backpack/Font/Classes/BPKFont.h',
    'Backpack/Radii/Classes/BPKRadii.h',
    'Backpack/Shadow/Classes/BPKShadow.h',
    'Backpack/Spacing/Classes/BPKSpacing.h'
  ]
  s.public_header_files = 'Backpack/Backpack.h', 'Backpack/*/Classes/**/*.h'
  s.dependency 'FloatingPanel', '2.8.6'
  s.dependency 'Backpack-Common'
  s.frameworks = 'UIKit', 'Foundation', 'CoreText'
  s.requires_arc = true
  s.swift_versions = ['5.0', '4.2', '4.0']
  s.pod_target_xcconfig = {
    'HEADER_SEARCH_PATHS' => '$(inherited) "${PODS_TARGET_SRCROOT}/Backpack" "${PODS_TARGET_SRCROOT}/Backpack/BorderWidth/Classes" "${PODS_TARGET_SRCROOT}/Backpack/Color/Classes" "${PODS_TARGET_SRCROOT}/Backpack/Duration/Classes" "${PODS_TARGET_SRCROOT}/Backpack/Font/Classes" "${PODS_TARGET_SRCROOT}/Backpack/Radii/Classes" "${PODS_TARGET_SRCROOT}/Backpack/Shadow/Classes" "${PODS_TARGET_SRCROOT}/Backpack/Spacing/Classes"'
  }
  s.test_spec 'SnapshotTests' do |test_spec|
    test_spec.dependency 'SnapshotTesting', '~> 1.9.0'
    test_spec.source_files = 'Backpack/Tests/SnapshotTests/**/*.{swift,h,m}'
    test_spec.ios.resource_bundle = {
    'SnapshotTestImages' => 'Backpack/Tests/SnapshotTests/Images*'
  }
  end  

  s.test_spec 'UnitTests' do |test_spec|
    test_spec.source_files = 'Backpack/Tests/UnitTests/**/*.{swift,h,m}'
    test_spec.ios.resource_bundle = {
    'UnitTestImages' => 'Backpack/Tests/UnitTests/Images*'
  }
  end  
end
