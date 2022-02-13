/** @type {import('next').NextConfig} */

module.exports = {
  reactStrictMode: true,
  async rewrites() {
    return [
      {
        source: '/api/session',
        destination: 'http://localhost:3001/api/session'
      },
      {
        source: '/api/:path*',
        destination: 'http://localhost:3000/api/:path*'
      },
    ]
  },
  i18n: {
    locales: ['en', 'ru'],
    defaultLocale: 'ru',
    localeDetection: false,
    domains: [
      {
        domain: 'golovinamari.local', defaultLocale: 'ru',
      },
      {
        domain: 'en.golovinamari.local', defaultLocale: 'en',
      },
      // {
      //   domain: 'golovinamari.local', defaultLocale: 'fr',
      // },
      // {
      //   domain: 'en.golovinamari.local', defaultLocale: 'en', locales: ['en'], http: true,
      // }
    ],
  },
  webpack(config) {
    config.module.rules.push({
      test: /\.svg$/i,
      issuer: /\.[jt]sx?$/,
      use: ['@svgr/webpack']
    })

    return config
  },
}
