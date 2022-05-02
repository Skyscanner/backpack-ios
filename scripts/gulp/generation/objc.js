const rename = require('gulp-rename');

const objectiveC = (generate) => {
  const streams = [
    'Color',
    'Font',
    'Spacing',
    'Radii',
    'BorderWidth',
    'Shadow',
    'Duration',
  ].map(processedType => {
    const destinationPrefix = `${processedType}/Classes/Generated`;
    return {
      files: [
        generate(`BPK${processedType}.h.njk`, rename(`${destinationPrefix}/BPK${processedType}.h`)),
        generate(`BPK${processedType}.m.njk`, rename(`${destinationPrefix}/BPK${processedType}.m`))
      ]
    };
  }).reduce((acc, curVal) => {
    return acc.concat(curVal.files);
  }, []);

  streams.push(generate('UIColor+Backpack.h.njk', rename('Color/Classes/Generated/UIColor+Backpack.h')));
  streams.push(generate('UIColor+Backpack.m.njk', rename('Color/Classes/Generated/UIColor+Backpack.m')));
  return streams;
}

module.exports = objectiveC