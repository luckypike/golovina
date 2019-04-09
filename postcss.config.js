module.exports = {
  plugins: [
    require('postcss-import'),
    require('postcss-flexbugs-fixes'),
    require('postcss-preset-env')({
      importFrom: './app/javascript/components/Vars.css',
      autoprefixer: {
        flexbox: 'no-2009'
      },
      features: {
        'custom-media-queries': true,
        'nesting-rules': true,
        'color-mod-function': { unresolved: 'warn' },
      },
      stage: 3
    })
  ]
}
