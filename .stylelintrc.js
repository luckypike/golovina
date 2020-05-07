module.exports = {
  extends: [
    'stylelint-config-standard'
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
