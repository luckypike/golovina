import App, { AppContext, AppProps } from 'next/app'
import React, { FC, useEffect, useState } from 'react'
import axios, { AxiosRequestConfig } from 'axios'
import { BugsnagPluginReactResult } from '@bugsnag/plugin-react'

import { Header } from '../layout/Header'
import { RootContext } from '../services/useRootContext'
import { RootStore, SessionData } from '../services/stores/RootStore'
import Bugsnag from '../lib/bugsnag'

import 'normalize.css'
import '../css/app.css'

const plugin = Bugsnag.getPlugin('react') as BugsnagPluginReactResult
const ErrorBoundary = plugin.createErrorBoundary(React)

axios.defaults.baseURL = process.env.NEXT_PUBLIC_API_URL

function AppPage({ Component, pageProps, sessionData }: AppProps & { sessionData: SessionData }) {
  const [rootStore] = useState(new RootStore(sessionData))

  return (
    <ErrorBoundary FallbackComponent={ErrorView}>
    <RootContext.Provider value={rootStore}>
      <Header />
      <main className="main">
        <Component {...pageProps} />
      </main>
    </RootContext.Provider>
    </ErrorBoundary>
  )
}

const ErrorView: FC = () => {
  return (<div>ERROR PAGE</div>)
}

AppPage.getInitialProps = async (appContext: AppContext) => {
  const appProps = await App.getInitialProps(appContext)

  let config: AxiosRequestConfig = {
    baseURL: process.env.NEXT_PUBLIC_API_URL,
    withCredentials: true,
  }

  if (appContext.ctx.req) {
    config = {
      baseURL: process.env.FASTAPI_URL,
      headers: { Cookie: appContext.ctx.req?.headers.cookie ?? '' },
    }
  }

  const { data: sessionData } = await axios.get<SessionData>('/session', config)
  return { ...appProps, sessionData }
}

export default AppPage
