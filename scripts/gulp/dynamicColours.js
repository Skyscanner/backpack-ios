const _ = require('lodash');

const dynamicColors = (properties, isDynamicColor) => _.chain(properties)
  .filter((entity) => entity.type === 'color' && isDynamicColor(entity))
  .map(
    ({
      value,
      originalValue,
      darkValue,
      originalDarkValue,
      name,
      ...rest
    }) => ({
      value: _.camelCase(originalValue),
      darkValue: _.camelCase(originalDarkValue),
      name: name[0].toLowerCase() + name.slice(1),
      hex: value.toString(),
      darkHex: darkValue.toString(),
      ...rest,
      type: 'dynamicColor',
    }),
  )
  .value();

module.exports = dynamicColors