const iconNames = (format) => {
  const content = require('@skyscanner/bpk-svgs/dist/font/iconMapping.json')
  const combinedEntries = Object.entries(content).filter((x) => !x[0].endsWith('-sm'));
  const smallEntries = Object.entries(content).filter((x) => x[0].endsWith('-sm'));
  const largeEntries = Object.entries(content).filter((x) => !x[0].endsWith('-sm') && !x[0].endsWith('-xl'));
  const xlEntries = Object.entries(content).filter((x) => x[0].endsWith('-xl'));

  const codify = (name) =>
    name
      .replace('--', '-')
      .split('-')
      .map(format)
      .join('')
      .replace('Ios', 'iOS');

  // Once we drop support for the legacy API, we can leave the suffix in the string
  // so that `BPKIcon.m` doesn't need to add it back in programmatically
  const templateData = (entries, suffix = '') =>
    Object.assign(
      ...entries.map(([k]) => {
        const key = k.endsWith(suffix)
          ? k.substring(0, k.length - suffix.length)
          : k;
        return {
          [key]: codify(key),
        };
      }),
    );

  return {
    icons: templateData(combinedEntries),
    smallIcons: templateData(smallEntries, '-sm'),
    largeIcons: templateData(largeEntries),
    xlIcons: templateData(xlEntries, '-xl'),
  }
}

module.exports = iconNames