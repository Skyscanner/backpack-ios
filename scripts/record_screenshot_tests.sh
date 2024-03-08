#!/bin/bash
# Backpack for iOS - Skyscanner's Design System
#
# Copyright 2018 Skyscanner Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
set -e

find . -name '__Snapshots__' -type d -exec rm -rf {} \;

# Get the directory of the currently running script
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

"$SCRIPT_DIR/ci" uikitsnapshot test;
"$SCRIPT_DIR/ci" swiftui test;