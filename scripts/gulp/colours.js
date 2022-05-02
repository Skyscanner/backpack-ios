const _ = require('lodash');

const colors = (properties, isDynamicColor, parseColor) => {
  const colorsa = _.chain(properties)
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

  colorsa.forEach(({ value, name, hex, type, ...rest }) => {
    const matchingValueColors = colorsa.filter(
      (c) => c.type === 'valueColor' && c.hex === hex && c.name !== name,
    );
    if (matchingValueColors.length > 0) {
      colorsa.push({
        value,
        name,
        hex,
        reference: matchingValueColors[0].name,
        type: 'referenceColor',
        ...rest,
      });
    } else {
      colorsa.push({
        value,
        name,
        hex,
        type: 'valueColor',
        ...rest,
      });
    }
  });
  return colorsa
}

module.exports = colors