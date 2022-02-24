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
        source: '/api/delivery_cities',
        destination: 'http://localhost:3001/api/delivery_cities'
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
        domain: 'golovinamari.com', defaultLocale: 'ru',
      },
      {
        domain: 'en.golovinamari.com', defaultLocale: 'en',
      }
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
