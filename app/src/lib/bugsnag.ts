import Bugsnag from '@bugsnag/js'
import BugsnagPluginReact from '@bugsnag/plugin-react'

Bugsnag.start({
  apiKey: process.env.NEXT_PUBLIC_BUGSNAG_API_KEY ?? '',
  enabledReleaseStages: ['production'],
  plugins: [new BugsnagPluginReact()],
})

export default Bugsnag
