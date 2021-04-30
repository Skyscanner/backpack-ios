/*
 *
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2016-2021 Skyscanner Ltd
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

import { danger, fail, warn, markdown, schedule } from 'danger';

const getRandomFromArray = (arr) => arr[Math.floor(Math.random() * arr.length)];
const currentYear = new Date().getFullYear();
// Applies to js, css, scss and sh files that are not located in dist or flow-typed folders.
const shouldContainLicensingInformation = (filePath) =>
  filePath.match(/\.(js|sh|swift|h|m|njk)$/);

const author = danger.github.pr.user.login;
const isPrExternal = async () => {
  try {
    await danger.github.api.orgs.checkMembership({
      org: 'backpack',
      username: author,
    });
    return false;
  } catch (err) {
    return true;
  }
};

const createdFiles = danger.git.created_files;
const modifiedFiles = danger.git.modified_files;
const fileChanges = [...modifiedFiles, ...createdFiles];

const thanksGifs = [
  'https://media.giphy.com/media/KJ1f5iTl4Oo7u/giphy.gif', // T.Hanks
  'https://media.giphy.com/media/6tHy8UAbv3zgs/giphy.gif', // Spongebob
  'https://media.giphy.com/media/xULW8v7LtZrgcaGvC0/giphy.gif', // Dog
  'https://media.giphy.com/media/GghJ32T5oPR8Q/giphy.gif', // Leslie Knope
  'https://media.giphy.com/media/26AHAw0aMmWwRI4Hm/giphy.gif', // David Mitchell
  'https://media.giphy.com/media/mbhseRYedlG5W/giphy.gif', // That guy from Who's Line Is It Anyway who looks like Bill Murray
  'https://media.giphy.com/media/3o6ZsXRBB9E67nUjL2/giphy.gif', // We love you
  'https://media.giphy.com/media/l3V0sNZ0NGomeurCM/giphy.gif', // Bowie
  'https://media.giphy.com/media/3rgXBvoeXt3MXlqhO0/giphy.gif', // Amazement
  'https://media.giphy.com/media/1OnDp7RwgphjG/giphy.gif', // Kumamon
  'https://media.giphy.com/media/1lk1IcVgqPLkA/giphy.gif', // Cap salute
  'https://media.giphy.com/media/l3V0lN5bUX7AKtdW8/giphy.gif', // Moira Schitt's Creek
  'https://media.giphy.com/media/3osxYdXvsGw6wT5lIY/giphy.gif', // OMG thanks
  'https://media.giphy.com/media/nEMmyUp4hl1QOzovKh/giphy.gif', // thanks dude
  'https://media.giphy.com/media/l0G192kSMLwTpO1CE/giphy.gif', // moe simpsons
];

// Be nice to our neighbours.
schedule(async () => {
  if (await isPrExternal()) {
    markdown(`
# Hi ${author}!

Thanks for the PR 🎉! Contributions like yours help to improve the design system
for everybody and we appreciate you taking the effort to create this PR.

![Thanks](${getRandomFromArray(thanksGifs)})

- [ ] Check this if you have read and followed the [contributing guidelines](https://github.com/Skyscanner/backpack-ios/blob/main/CONTRIBUTING.md)

If you're curious about how we review, please read through the
[code review guidelines](https://github.com/Skyscanner/backpack/blob/main/CODE_REVIEW_GUIDELINES.md).
`);
  }
});

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

// Updated files should include the latest year in licensing header.
const outdatedLicenses = fileChanges.filter((filePath) => {
  if (
    shouldContainLicensingInformation(filePath) &&
    !unlicensedFiles.includes(filePath)
  ) {
    const fileContent = fs.readFileSync(filePath);
    return !fileContent.includes(
      `Copyright 2018-${currentYear} Skyscanner Ltd`,
    );
  }
  return false;
});
if (outdatedLicenses.length > 0) {
  fail(
    `These files contain an outdated licensing header: ${outdatedLicenses.join(
      ', ',
    )}. Please update to ${currentYear}.`,
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
