# Backpack - Skyscanner's Design System

# Copyright 2018-2021 Skyscanner Ltd

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#   http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

Pod::Spec.new do |spec|
  spec.name         = "Fonts"
  spec.version      = "0.0.1"
  spec.summary      = <<-DESC
    A local pod that can optionaly contain Skyscanner fonts to include in the bundle.
                       DESC
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
  spec.prepare_command = 'Scripts/download-relative-fonts.rb'
end
