import { FC } from 'react'
import { useTranslations } from 'next-intl'

import s from './index.module.css'

const NewRefund: FC = () => {
  const t = useTranslations('NewRefund')

  return (
    <div className={s.root}>
      <h1>{t('title')}</h1>
    </div>
  )
}

export default NewRefund
