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
        source: '/api/rails/active_storage/direct_uploads.json',
        destination: 'http://localhost:3000/rails/active_storage/direct_uploads.json'
      },
      {
        source: '/api/:path*',
        destination: 'http://localhost:3000/api/:path*'
      },
    ]
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
