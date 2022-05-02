const _ = require('lodash');
const tinycolor = require('tinycolor2');

const capitaliseFirstLetter = (s) => s[0].toUpperCase() + _.camelCase(s.substring(1));

const parseColor = (color) => {
  const { r, g, b, a } = tinycolor(color).toRgb();
  return {
    r255: r,
    g255: g,
    b255: b,
    r: (r / 255.0).toFixed(3),
    g: (g / 255.0).toFixed(3),
    b: (b / 255.0).toFixed(3),
    a,
  };
};

const isDynamicColor = (entity) => entity.value && entity.darkValue;
const formatPrefixedConstName = (name) => `BPK${name.charAt(0).toUpperCase()}${name.slice(1)}`

module.exports = {
  capitaliseFirstLetter,
  parseColor,
  isDynamicColor,
  formatPrefixedConstName
}