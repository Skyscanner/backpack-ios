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
  s.name             = "Backpack"
  s.version          = "0.6.2"
  s.summary          = "Skyscanner's Design System Backpack for iOS"

  s.description      = <<-DESC
  The Skyscanner Design System, Backpack, for iOS apps
                       DESC

  s.homepage         = "https://github.com/Skyscanner/backpack-ios"
  s.license          = { type: "Apache-2.0", file: "LICENSE" }
  s.author           = {
    "Backpack Design System" => "backpack@skyscanner.net"
  }
  s.source = {
    git: "https://github.com/Skyscanner/backpack-ios.git", tag: s.version.to_s
  }
  s.ios.deployment_target = "9.0"
  s.source_files = 'Backpack/Classes/Backpack.h'
  s.public_header_files = 'Backpack/Classes/Backpack.h'

  s.subspec 'Color' do |ss|
    ss.source_files = 'Backpack/Classes/Color/**/*.{h,m}'
    ss.public_header_files = 'Backpack/Classes/Color/**/*.h'
  end

  s.subspec 'Font' do |ss|
    ss.source_files = 'Backpack/Classes/Font/**/*.{h,m}'
    ss.public_header_files = 'Backpack/Classes/Font/**/*.h'
  end

  s.subspec 'Spacing' do |ss|
    ss.source_files = 'Backpack/Classes/Spacing/**/*.{h,m}'
    ss.public_header_files = 'Backpack/Classes/Spacing/**/*.h'
  end

  s.subspec 'Radii' do |ss|
    ss.source_files = 'Backpack/Classes/Radii/**/*.{h,m}'
    ss.public_header_files = 'Backpack/Classes/Radii/**/*.h'
  end

  s.subspec 'Shadow' do |ss|
    ss.source_files = 'Backpack/Classes/Shadow/**/*.{h,m}'
    ss.public_header_files = 'Backpack/Classes/Shadow/**/*.h'
  end

  s.subspec 'Gradient' do |ss|
    ss.source_files = 'Backpack/Classes/Gradient/**/*.{h,m}'
    ss.public_header_files = 'Backpack/Classes/Gradient/**/*.h'
    ss.dependency 'Backpack/Color'
  end

  s.frameworks = "UIKit", "Foundation"
  s.requires_arc = true
end
