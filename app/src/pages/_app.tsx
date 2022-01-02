import App, { AppContext, AppProps } from 'next/app'
import { useEffect, useState } from 'react'
import axios from 'axios'

import { Header } from '../layout/Header'
import { RootContext } from '../services/useRootContext'
import { RootStore, SessionData } from '../services/stores/RootStore'

import 'normalize.css'
import '../css/app.css'

axios.defaults.baseURL = process.env.API_URL

function AppPage({ Component, pageProps, sessionData }: AppProps & { sessionData: SessionData }) {
  const [rootStore] = useState(new RootStore(sessionData))

  return (
    <RootContext.Provider value={rootStore}>
      <Header />
      <main className="main">
        <Component {...pageProps} />
      </main>
    </RootContext.Provider>
  )
}

AppPage.getInitialProps = async (appContext: AppContext) => {
  const appProps = await App.getInitialProps(appContext)

  axios.defaults.headers.common.Cookie = appContext.ctx.req?.headers.cookie ?? ''
  axios.defaults.baseURL = process.env.API_URL_SSR

  const { data } = await axios.get('/session')

  return { ...appProps, sessionData: data }
}

export default AppPage
