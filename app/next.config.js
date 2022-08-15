/** @type {import('next').NextConfig} */

const { withSentryConfig } = require('@sentry/nextjs')

const moduleExports = {
  reactStrictMode: true,
  async rewrites() {
    return [
      {
        source: '/api/session',
        destination: 'http://localhost:3001/api/session',
      },
      {
        source: '/api/delivery_cities',
        destination: 'http://localhost:3001/api/delivery_cities',
      },
      {
        source: '/api/:path*',
        destination: 'http://localhost:3000/api/:path*',
      },
      {
        source: '/orders/paid',
        destination: 'http://localhost:3000/orders/paid',
      },
    ]
  },
  i18n: {
    locales: ['en', 'ru'],
    defaultLocale: 'ru',
    localeDetection: false,
    domains: [
      {
        domain: 'golovinamari.com',
        defaultLocale: 'ru',
      },
      {
        domain: 'en.golovinamari.com',
        defaultLocale: 'en',
      },
    ],
  },
  webpack(config) {
    config.module.rules.push({
      test: /\.svg$/i,
      issuer: /\.[jt]sx?$/,
      use: ['@svgr/webpack'],
    })

    return config
  },
}

const sentryWebpackPluginOptions = {
  // Additional config options for the Sentry Webpack plugin. Keep in mind that
  // the following options are set automatically, and overriding them is not
  // recommended:
  //   release, url, org, project, authToken, configFile, stripPrefix,
  //   urlPrefix, include, ignore

  silent: true, // Suppresses all logs
  // For all available options, see:
  // https://github.com/getsentry/sentry-webpack-plugin#options.
}

// Make sure adding Sentry options is the last code to run before exporting, to
// ensure that your source maps include changes from all other Webpack plugins
module.exports = withSentryConfig(moduleExports, sentryWebpackPluginOptions)
