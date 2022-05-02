const _ = require('lodash');

const VALID_SPACINGS = new Set([
  'none',
  'sm',
  'md',
  'base',
  'lg',
  'xl',
  'xxl',
  'icontext',
]);

const spacings = (properties, formatName, getLegibleName) => _.chain(properties)
  .filter(({ category }) => category === 'spacings')
  .filter(({ name }) =>
    VALID_SPACINGS.has(name.replace('spacing', '').toLowerCase()),
  )
  .map(({ name, value }) => {
    return {
      type: 'spacing',
      name: formatName(name),
      value,
      legibleName: getLegibleName(name),
    }
  })
  .sortBy((s) => parseInt(s.value, 10))
  .value();

module.exports = spacings