const _ = require('lodash');

const VALID_RADII = new Set(['xs', 'sm', 'md', 'lg', 'pill']);

const radii = (properties, formatName, getLegibleName) => _.chain(properties)
  .filter(({ category }) => category === 'radii')
  .filter(({ name }) =>
    VALID_RADII.has(name.replace('cornerRadius', '').toLowerCase()),
  )
  .map(({ name, value }) => {
    return {
      type: 'radii',
      name: formatName(name),
      value,
      legibleName: getLegibleName(name),
    }
  })
  .value();

module.exports = radii