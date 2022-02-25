/*
 *
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

// See http://danger.systems/js if you're not sure what this is.

// Globals provided by Danger
import fs from 'fs';

import { danger, fail, warn, schedule } from 'danger';

// Applies to js, css, scss and sh files that are not located in dist or flow-typed folders.
const shouldContainLicensingInformation = (filePath) =>
  filePath.match(/\.(js|sh|swift|h|m|njk)$/);

const createdFiles = danger.git.created_files;
const modifiedFiles = danger.git.modified_files;
const fileChanges = [...modifiedFiles, ...createdFiles];

const pbxprojFilePath = 'Example/Backpack.xcodeproj/project.pbxproj';

const projectFileMentionsRelative = async () => {
  const stat = await fs.promises.stat(pbxprojFilePath);
  if (!stat.isFile()) {
    return false;
  }

  const content = await fs.promises.readFile(pbxprojFilePath, {
    encoding: 'utf-8',
  });
  return content.includes('SkyscannerRelative');
};

const hasNonRTLAnchor = async (filePath) => {
  const stat = await fs.promises.stat(filePath);
  if (!stat.isFile()) {
    return false;
  }

  const content = await fs.promises.readFile(filePath, { encoding: 'utf-8' });
  return content.includes('leftAnchor') || content.includes('rightAnchor');
};

// New files should include the Backpack license heading.
const unlicensedFiles = createdFiles.filter(filePath => {
  if (shouldContainLicensingInformation(filePath)) {
    const fileContent = fs.readFileSync(filePath);
    return !fileContent.includes(
      'Licensed under the Apache License, Version 2.0 (the "License")',
    );
  }
  return false;
});
if (unlicensedFiles.length > 0) {
  fail(
    `These new files do not include the license heading: ${unlicensedFiles.join(
      ', ',
    )}`,
  );
}

const listOfFilesExcludingThisOne = fileChanges.filter(
  (path) => path !== 'dangerfile.js',
);

schedule(async () => {
  const usesNonRTLAnchor = await Promise.all(
    listOfFilesExcludingThisOne.map(hasNonRTLAnchor),
  ).then((values) => values.some((x) => x));

  if (usesNonRTLAnchor) {
    warn(
      'You have used `leftAnchor` or `rightAnchor`. These should generally be avoided to ensure that RTL is supported.',
    );
  }

  if (await projectFileMentionsRelative()) {
    fail(
      `Project file "${pbxprojFilePath}" references "SkyscannerRelative". This change should not be checked in.`,
    );
  }
});
