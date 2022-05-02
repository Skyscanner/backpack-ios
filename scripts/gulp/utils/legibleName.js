const LEGIBLE_NAMES = [
  { identifier: 'Xs', legibleName: 'extra small' },
  { identifier: 'Sm', legibleName: 'small' },
  { identifier: 'Md', legibleName: 'medium' },
  { identifier: 'Base', legibleName: 'base' },
  { identifier: 'Lg', legibleName: 'large' },
  { identifier: 'Xl', legibleName: 'extra large' },
  { identifier: 'Xxl', legibleName: 'extra extra large' },
  { identifier: 'Xxxl', legibleName: 'extra extra extra large' },
  { identifier: 'Pill', legibleName: 'pill' },
  { identifier: 'None', legibleName: 'none' },
  { identifier: 'IconText', legibleName: 'icon text' },
];

const getLegibleName = (name) => {
  let result = null;
  LEGIBLE_NAMES.forEach((t) => {
    if (name.includes(t.identifier)) {
      result = t.legibleName;
    }
  });
  if (result) {
    return result;
  }
  throw new Error(`No legible name found for ${name}`);
};

module.exports = getLegibleName