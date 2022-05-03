const _ = require('lodash');

const colors = (properties, isDynamicColor, parseColor) => {
  const colors = _.chain(properties)
    .filter((entity) => entity.type === 'color' && !isDynamicColor(entity))
    .map(({ value, name, ...rest }) => {
      const newName = name.replace('color', '');

      return {
        value: parseColor(value),
        name: newName[0].toLowerCase() + newName.slice(1),
        hex: value.toString(),
        ...rest,
      };
    })
    .value();

  colors.forEach(({ value, name, hex, ...rest }) => {
    const matchingValueColors = colors.filter(
      (c) => c.type === 'valueColor' && c.hex === hex && c.name !== name,
    );
    if (matchingValueColors.length > 0) {
      colors.push({
        value,
        name,
        hex,
        reference: matchingValueColors[0].name,
        ...rest,
        type: 'referenceColor',
      });
    } else {
      colors.push({
        value,
        name,
        hex,
        ...rest,
        type: 'valueColor',
      });
    }
  });
  return colors
}

module.exports = colors