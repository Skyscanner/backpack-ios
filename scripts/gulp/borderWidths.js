const _ = require('lodash');

const VALID_BORDER_WIDTHS = new Set(['sm', 'lg', 'xl']);

const borderWidths = (properties, formatName, getLegibleName) => _.chain(properties)
  .filter(({ category }) => category === 'borders')
  .filter(({ name }) =>
    VALID_BORDER_WIDTHS.has(name.replace('borderWidth', '').toLowerCase()),
  )
  .map(({ name, value }) => {
    return {
      type: 'borders',
      name: formatName(name),
      value,
      legibleName: getLegibleName(name),
    }
  })
  .value();

module.exports = borderWidths