const _ = require('lodash');

const VALID_SHADOWS = new Set(['sm', 'lg']);

const shadows = (properties, parseColor, getLegibleName) => _.chain(properties)
  .filter(({ category }) => category === 'box-shadows')
  .filter(({ name }) => {
    const size = name
      .replace('shadow', '')
      .replace('Color', '')
      .replace('OffsetHeight', '')
      .replace('OffsetWidth', '')
      .replace('Opacity', '')
      .replace('Radius', '');
    return VALID_SHADOWS.has(size.toLowerCase());
  })
  .groupBy(({ name }) =>
    name
      .replace('OffsetHeight', '')
      .replace('OffsetWidth', '')
      .replace('Opacity', '')
      .replace('Radius', '')
      .replace('Color', ''),
  )
  .map((values, key) => [values, key])
  .map(([properties, key]) => {
    const findByName = (name) => ({ name: packageName }) =>
      packageName === name;
    const offsetHeightProp = _.filter(
      properties,
      findByName(`${key}OffsetHeight`),
    );
    const offsetWidthProp = _.filter(
      properties,
      findByName(`${key}OffsetWidth`),
    );
    const opacityProp = _.filter(properties, findByName(`${key}Opacity`));
    const radiusProp = _.filter(properties, findByName(`${key}Radius`));
    const colorProp = _.filter(properties, findByName(`${key}Color`));

    if (
      offsetHeightProp.length === 0 ||
      offsetWidthProp.length === 0 ||
      opacityProp.length === 0 ||
      radiusProp.length === 0 ||
      colorProp.length === 0
    ) {
      throw new Error(
        `Expected all shadow definitions to have offset, opacity, radius and color. ${key} did not`,
      );
    }

    return {
      name: key,
      type: 'shadow',
      offset: {
        x: offsetWidthProp[0].value,
        y: offsetHeightProp[0].value,
      },
      color: parseColor(colorProp[0].value),
      opacity: opacityProp[0].value,
      radius: radiusProp[0].value,
      legibleName: getLegibleName(key),
    };
  })
  .value();

module.exports = shadows