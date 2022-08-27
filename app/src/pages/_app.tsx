import React, { useEffect, useState } from 'react'
import App, { AppContext, AppProps } from 'next/app'
import router from 'next/router'
import axios, { AxiosRequestConfig } from 'axios'
import { IntlMessages, NextIntlProvider } from 'next-intl'

import { Header } from '../layout/Header'
import { Footer } from '../layout/Footer'
import { Metrics } from '../modules/Metrics'
import { RootContext } from '../services/useRootContext'
import { RootStore, SessionData } from '../services/stores/RootStore'

import 'normalize.css'
import '../css/app.css'
import '../css/react-select.css'

axios.defaults.baseURL = process.env.NEXT_PUBLIC_API_URL
// axios.defaults.headers.get['Content-Type'] = 'application/json'
// axios.defaults.headers.post['Content-Type'] = 'application/json'

function AppPage({
  Component,
  pageProps,
  sessionData,
  localeData,
  transactionId,
}: AppProps & {
  sessionData: SessionData
  localeData: IntlMessages
  transactionId: string
}): JSX.Element {
  const [rootStore] = useState(new RootStore(sessionData, transactionId))

  useEffect(() => {
    const handleRouteChange = (): void => {
      rootStore.layoutStore.setActiveNav(false)
    }

    router.events.on('routeChangeStart', handleRouteChange)

    return () => {
      router.events.off('routeChangeStart', handleRouteChange)
    }
  }, [rootStore.layoutStore])

  return (
    <RootContext.Provider value={rootStore}>
      <NextIntlProvider messages={localeData}>
        <Header />

        <main className="main">
          <Component {...pageProps} />
        </main>

        <Footer />
        <Metrics />
      </NextIntlProvider>
    </RootContext.Provider>
  )
}

AppPage.getInitialProps = async (appContext: AppContext) => {
  const appProps = await App.getInitialProps(appContext)
  const locale = appContext.ctx.locale ?? 'ru'
  const transactionId = Math.random().toString(36).substr(2, 9)

  let config: AxiosRequestConfig = {
    baseURL: process.env.NEXT_PUBLIC_API_URL,
    withCredentials: true,
    headers: {
      'X-Locale': locale,
      'X-Transaction-ID': transactionId,
    },
  }

  if (appContext.ctx.req != null) {
    config = {
      baseURL: process.env.FASTAPI_URL,
      headers: {
        Cookie: appContext.ctx.req?.headers.cookie ?? '',
        'X-Locale': locale,
        'X-Transaction-ID': transactionId,
      },
    }
  }

  const localeData = (await import(`../locale/${locale}.json`)).default

  const { data: sessionData } = await axios.get<SessionData>('/session', config)
  return { ...appProps, sessionData, localeData, transactionId }
}

export default AppPage
