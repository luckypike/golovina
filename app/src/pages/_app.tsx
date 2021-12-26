import axios from 'axios';
import App, { AppContext, AppProps } from 'next/app';
import { User } from '../models';

axios.defaults.baseURL = '/api'

function AppPage({ Component, pageProps }: AppProps) {
  return <>
  <p>APP:</p>
  <Component {...pageProps} /></>
}

AppPage.getInitialProps = async (appContext: AppContext) => {
  const appProps = await App.getInitialProps(appContext);

  axios.defaults.headers.common.Cookie = appContext.ctx.req?.headers.cookie ?? ''

  return { ...appProps }
}

export default AppPage
