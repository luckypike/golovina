import App, { AppContext, AppProps } from 'next/app'
import React, { FC, useEffect, useState } from 'react'
import axios, { AxiosRequestConfig } from 'axios'
import { BugsnagPluginReactResult } from '@bugsnag/plugin-react'
import { IntlMessages, NextIntlProvider } from 'next-intl'

import { Header } from '../layout/Header'
import { Footer } from '../layout/Footer'
import { RootContext } from '../services/useRootContext'
import { RootStore, SessionData } from '../services/stores/RootStore'
import Bugsnag from '../lib/bugsnag'

import 'normalize.css'
import '../css/app.css'
import router from 'next/router'

const plugin = Bugsnag.getPlugin('react') as BugsnagPluginReactResult
const ErrorBoundary = plugin.createErrorBoundary(React)

axios.defaults.baseURL = process.env.NEXT_PUBLIC_API_URL

function AppPage({ Component, pageProps, sessionData, localeData }: AppProps & { sessionData: SessionData, localeData: IntlMessages }) {
  const [rootStore] = useState(new RootStore(sessionData))

  useEffect(() => {
    const handleRouteChange = () => {
      rootStore.layoutStore.setActiveNav(false)
    }

    router.events.on('routeChangeStart', handleRouteChange)

    return () => {
      router.events.off('routeChangeStart', handleRouteChange)
    }
  }, [rootStore.layoutStore])

  return (
    <ErrorBoundary FallbackComponent={ErrorView}>
      <RootContext.Provider value={rootStore}>
        <NextIntlProvider messages={localeData}>
          <Header />

          <main className="main">
            <Component {...pageProps} />
          </main>

          <Footer />
        </NextIntlProvider>
      </RootContext.Provider>
    </ErrorBoundary>
  )
}

const ErrorView: FC = () => {
  return <div>ERROR PAGE</div>
}

AppPage.getInitialProps = async (appContext: AppContext) => {
  const appProps = await App.getInitialProps(appContext)
  const locale = appContext.ctx.locale ?? 'ru'

  let config: AxiosRequestConfig = {
    baseURL: process.env.NEXT_PUBLIC_API_URL,
    withCredentials: true,
    headers: {
      'X-Locale': locale,
    },
  }

  if (appContext.ctx.req) {
    config = {
      baseURL: process.env.FASTAPI_URL,
      headers: {
        Cookie: appContext.ctx.req?.headers.cookie ?? '',
        'X-Locale': locale,
      },
    }
  }

  const localeData = (await import(`../locale/${locale}.json`)).default

  const { data: sessionData } = await axios.get<SessionData>('/session', config)
  return { ...appProps, sessionData, localeData }
}

export default AppPage
