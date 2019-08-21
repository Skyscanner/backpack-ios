# Backpack - Skyscanner's Design System

# Copyright 2018-2019 Skyscanner Ltd

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
  s.version          = "14.2.0"
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
  s.ios.deployment_target = '10.0'
  s.source_files = 'Backpack/Backpack.h', 'Backpack/Common.h', 'Backpack/*/Classes/**/*.{h,m,swift}'
  s.public_header_files = 'Backpack/Backpack.h', 'Backpack/*/Classes/**/*.h'
  s.ios.resource_bundle = {
    'Icon' => 'Backpack/Icon/Assets/*'
  }
  s.dependency 'FloatingPanel', '~> 1.6'
  s.dependency 'FSCalendar', '~> 2.8'
  s.dependency 'TTTAttributedLabel', '~> 1.13.4'
  s.frameworks = 'UIKit', 'Foundation', 'CoreText'
  s.requires_arc = true
  s.swift_version = '4.2'
end
