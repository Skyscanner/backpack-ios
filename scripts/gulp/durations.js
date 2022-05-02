const _ = require('lodash');

const parseDuration = (duration) => {
    const ms = parseInt(duration.replace('ms', ''), 10);
    return ms / 1000;
  };

const durations = (properties) => _.chain(properties)
    .filter(({ type }) => type === 'duration')
    .map(({ value, name, ...rest }) => ({
        value: parseDuration(value),
        name,
        ...rest,
    }))
    .value();

module.exports = durations