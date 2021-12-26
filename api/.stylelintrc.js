module.exports = {
  extends: [
    'stylelint-config-standard',
    'stylelint-config-css-modules'
  ],
  rules: {
    'property-no-unknown': [
      true,
      {
        ignoreProperties: ['composes', 'compose-with'],
      }
    ]
  }
}
