import axios from 'axios'
import { observer } from 'mobx-react-lite'
import { useTranslations } from 'next-intl'
import React, { FC, useEffect, useState } from 'react'
import { SubmitHandler, useForm } from 'react-hook-form'
import cc from 'classcat'

import { entries } from '../../../../models'

import s from './index.module.css'
import sf from '../../../../layout/form.module.css'
import sb from '../../../../css/buttons.module.css'
import { useCartContext } from '../../context'

interface Values {
  code: string
}

export const CodeModal: FC<{ phone: string }> = observer(({ phone }) => {
  const { setVerified } = useCartContext()

  const t = useTranslations('Cart.CodeModal')
  const {
    register,
    handleSubmit,
    setError,
    formState: { errors, isSubmitting },
  } = useForm<Values>()

  const onSubmit: SubmitHandler<Values> = async (data) => {
    try {
      await axios.post('/cart/verify', { ...data, phone })
      setVerified(true)
    } catch ({
      response: {
        status,
        data: { errors: errorsData },
      },
    }) {
      if (status === 404) {
        setError('code', { type: 'manual', message: t('error') })
      } else if (status === 422) {
        entries(errorsData as Record<keyof Values, string[]>).forEach(([name, messages]) => {
          messages.map((message) => setError(name, { type: 'manual', message }))
        })
      }
    }
  }

  const [submitted, setSubmitted] = useState(false)

  useEffect(() => {
    const _sendCode = async (): Promise<void> => {
      try {
        await axios.post('/session/code', { phone })
        setSubmitted(true)
      } catch {}
    }

    if (!submitted) {
      void _sendCode()
    }
  }, [submitted, setSubmitted, phone])

  return (
    <div className={s.root}>
      {submitted && (
        <form onSubmit={handleSubmit(onSubmit)}>
          <div className={s.desc}>{t('desc', { phone })}</div>

          <div className={sf.el}>
            <div className={sf.it}>
              <input type="text" className={sf.in} {...register('code')} placeholder={t('code')} />
            </div>

            {errors.code != null && <div className={sf.er}>{errors.code.message}</div>}
          </div>

          <div>
            <button className={cc([sb.main, { [sb.submitting]: isSubmitting }])} disabled={isSubmitting} type="submit">
              {t('submit')}
            </button>
          </div>
        </form>
      )}
    </div>
  )
})
