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
  s.version          = "0.14.0"
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
  s.ios.deployment_target = '9.0'
  s.source_files = 'Backpack/Backpack.h'
  s.public_header_files = 'Backpack/Backpack.h'

  # Tokens
  s.subspec 'Color' do |ss|
    ss.source_files = 'Backpack/Color/Classes/**/*.{h,m}'
    ss.public_header_files = 'Backpack/Color/Classes/**/*.h'
  end

  s.subspec 'Font' do |ss|
    ss.source_files = 'Backpack/Font/Classes/**/*.{h,m}'
    ss.public_header_files = 'Backpack/Font/Classes/**/*.h'
  end

  s.subspec 'Spacing' do |ss|
    ss.source_files = 'Backpack/Spacing/Classes/**/*.{h,m}'
    ss.public_header_files = 'Backpack/Spacing/Classes/**/*.h'
  end

  s.subspec 'Radii' do |ss|
    ss.source_files = 'Backpack/Radii/Classes/**/*.{h,m}'
    ss.public_header_files = 'Backpack/Radii/Classes/**/*.h'
  end

  s.subspec 'Shadow' do |ss|
    ss.source_files = 'Backpack/Shadow/Classes/**/*.{h,m}'
    ss.public_header_files = 'Backpack/Shadow/Classes/**/*.h'
  end

  s.subspec 'Gradient' do |ss|
    ss.source_files = 'Backpack/Gradient/Classes/**/*.{h,m}'
    ss.public_header_files = 'Backpack/Gradient/Classes/**/*.h'
    ss.dependency 'Backpack/Color'
  end

  # Components

  s.subspec 'Badge' do |ss|
    ss.source_files = 'Backpack/Badge/Classes/**/*.{h,m}'
    ss.public_header_files = 'Backpack/Badge/Classes/**/*.h'
    ss.dependency 'Backpack/Color'
    ss.dependency 'Backpack/Spacing'
    ss.dependency 'Backpack/Radii'
    ss.dependency 'Backpack/Font'
  end

  s.subspec 'Button' do |ss|
    ss.source_files = 'Backpack/Button/Classes/**/*.{h,m}'
    ss.public_header_files = 'Backpack/Button/Classes/**/*.h'
    ss.dependency 'Backpack/Color'
    ss.dependency 'Backpack/Spacing'
    ss.dependency 'Backpack/Gradient'
    ss.dependency 'Backpack/Font'
    ss.dependency 'Backpack/Label'
    ss.dependency 'Backpack/RTLSupport'
  end

  s.subspec 'Dialog' do |ss|
    ss.source_files = 'Backpack/Dialog/Classes/**/*.{h,m}'
    ss.public_header_files = 'Backpack/Dialog/Classes/**/*.h'
    ss.dependency 'Backpack/Button'
    ss.dependency 'Backpack/Shadow'
  end

  s.subspec 'Icon' do |ss|
    ss.source_files = 'Backpack/Icon/Classes/**/*.{h,m}'
    ss.public_header_files = 'Backpack/Icon/Classes/**/*.h'
    ss.ios.resource_bundle = {
      'Icon' => 'Backpack/Icon/Assets/*'
    }
    ss.frameworks = 'CoreText'
  end

  s.subspec 'Label' do |ss|
    ss.source_files = 'Backpack/Label/Classes/**/*.{h,m}'
    ss.public_header_files = 'Backpack/Label/Classes/**/*.h'
    ss.dependency 'Backpack/Color'
    ss.dependency 'Backpack/Font'
  end

  s.subspec 'TextView' do |ss|
    ss.source_files = 'Backpack/TextView/Classes/**/*.{h,m}'
    ss.public_header_files = 'Backpack/TextView/Classes/**/*.h'
    ss.dependency 'Backpack/Color'
    ss.dependency 'Backpack/Font'
  end

  s.subspec 'Panel' do |ss|
    ss.source_files = 'Backpack/Panel/Classes/**/*.{h,m}'
    ss.public_header_files = 'Backpack/Panel/Classes/**/*.h'
    ss.dependency 'Backpack/Color'
    ss.dependency 'Backpack/Spacing'
    ss.dependency 'Backpack/Radii'
  end

  s.subspec 'Spinner' do |ss|
    ss.source_files = 'Backpack/Spinner/Classes/**/*.{h,m}'
    ss.public_header_files = 'Backpack/Spinner/Classes/**/*.h'
    ss.dependency 'Backpack/Color'
  end

  s.subspec 'RTLSupport' do |ss|
    ss.source_files = 'Backpack/RTLSupport/Classes/**/*.{h,m}'
    ss.public_header_files = 'Backpack/RTLSupport/Classes/**/*.h'
  end

  s.frameworks = 'UIKit', 'Foundation'
  s.requires_arc = true
end
