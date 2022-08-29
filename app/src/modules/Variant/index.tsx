import { FC } from 'react'
import { useTranslations } from 'next-intl'
import Head from 'next/head'

import s from './index.module.css'

export const Variant: FC = () => {
  const t = useTranslations('Variant')

  return (
    <div className={s.root}>
      <Head>
        <title>{t('title')}</title>
      </Head>

      <h1 className={s.title}>{t('title')}</h1>

      <div className={s.container}>
        Catalog
      </div>
    </div>
  )
}
