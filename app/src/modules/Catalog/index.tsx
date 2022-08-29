import { FC } from 'react'
import { useTranslations } from 'next-intl'
import Head from 'next/head'
import { observer } from 'mobx-react-lite'

import s from './index.module.css'
import { defaultServerSideConfig } from '../../constants'
import { CatalogData } from './data'
import axios from 'axios'
import { useCatalogContext } from './context'
import Link from 'next/link'

export const Catalog: FC = observer(() => {
  const t = useTranslations('Catalog')
  const { variants } = useCatalogContext()

  return (
    <div className={s.root}>
      <Head>
        <title>{t('title')}</title>
      </Head>

      <h1 className={s.title}>{t('title')}</h1>

      <div className={s.container}>Catalog</div>
      <div>
        {variants.map((variant) => (
          <div key={variant.id}>
            <div>{variant.id}</div>
            {/* <Link href={`/catalog/${variant.id}`}>{variant.id}</Link> */}
          </div>
        ))}
      </div>
    </div>
  )
})

export const getCatalogData = async (slug?: string, locale?: string): Promise<CatalogData> => {
  console.log({
    ...defaultServerSideConfig(locale),
    params: { slug },
    baseURL: process.env.FASTAPI_URL,
  })

  const { data } = await axios.get<CatalogData>('/catalog', {
    ...defaultServerSideConfig(locale),
    params: { slug },
    baseURL: process.env.FASTAPI_URL,
  })

  return data
}
