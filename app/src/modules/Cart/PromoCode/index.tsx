import { FC } from 'react'
import axios from 'axios'
import { observer } from 'mobx-react-lite'
import { useTranslations } from 'next-intl'
import { SubmitHandler, useForm } from 'react-hook-form'
import cc from 'classcat'

import { useCartContext } from '../context'

import s from './index.module.css'
import sf from '../../../layout/form.module.css'
import sb from '../../../css/buttons.module.css'

interface Values {
  title: string
}

export const PromoCode: FC = observer(() => {
  const t = useTranslations('PromoCode')
  const { order, setReload } = useCartContext()
  const {
    register,
    handleSubmit,
    setValue,
    setError,
    formState: { errors },
  } = useForm<Values>()

  const onSubmit: SubmitHandler<Values> = async (data) => {
    try {
      await axios.post('/cart/promo_code', data)
      setReload(true)
    } catch {
      setError('title', { message: t('error') })
    }
  }

  const handleDelete = async (): Promise<void> => {
    try {
      await axios.delete('/cart/promo_code')
      setValue('title', '')
      setReload(true)
    } catch {
      setError('title', { message: t('arghh') })
    }
  }

  if (order == null) return null

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <h2 className={s.title}>{t('title')}</h2>

      {order.promo_code != null && (
        <div className={s.applied}>
          <div>
            {t('applied')}: {order.promo_code.title.toUpperCase()}
          </div>
          <div className={s.remove}>
            <button className={s.button} type="button" onClick={handleDelete}>
              {t('delete')}
            </button>
          </div>
        </div>
      )}

      {order.promo_code == null && (
        <div className={s.root}>
          <div className={s.input}>
            <input placeholder={t('placeholder')} className={cc([sf.in, sf.s])} type="text" {...register('title')} />
          </div>

          <div>
            <button className={cc([sb.main, sb.s])} type="submit">
              {t('apply')}
            </button>
          </div>
        </div>
      )}

      {errors.title != null && <div className={sf.er}>{errors.title.message}</div>}
    </form>
  )
})
