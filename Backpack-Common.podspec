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
  s.name             = 'Backpack-Common'
  s.version          = "49.0.3"
  s.summary          = "Skyscanner's Common Design Tokens for Backpack"

  s.description      = <<-DESC
  Skyscanner's Common Design Tokens for Backpack
                       DESC

  s.homepage         = 'https://github.com/Skyscanner/backpack-ios'
  s.license          = { type: 'Apache-2.0', file: 'LICENSE' }
  s.author           = {
    'Backpack Design System' => 'backpack@skyscanner.net'
  }
  s.source = {
    git: 'https://github.com/Skyscanner/backpack-ios.git', tag: s.version.to_s
  }
  s.ios.resource_bundle = {
    'Icons' => 'Backpack-Common/Icons/Assets/*'
  }
  s.ios.deployment_target = '14.0'
  s.source_files = 'Backpack-Common/**/*.swift'
  s.requires_arc = true
  s.swift_versions = ['5.0']
end
