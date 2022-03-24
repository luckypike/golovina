import { FC, useEffect } from 'react'
import Modal from 'react-modal'
import { observer } from 'mobx-react-lite'
import axios from 'axios'
import { Controller, SubmitHandler, useForm } from 'react-hook-form'
import { useTranslations } from 'next-intl'
import Cleave from 'cleave.js/react'
import cc from 'classcat'

import { useCartContext } from '../context'
import { entries } from '../../../models'
import { useRootContext } from '../../../services/useRootContext'

// import 'reactjs-popup/dist/index.css';
import s from './index.module.css'
import sf from '../../../layout/form.module.css'
import sb from '../../../css/buttons.module.css'
import { CodeModal } from './CodeModal'

interface Values {
  name: string
  sname: string
  email: string
  phone: string
  comment: string
}

export const Checkout: FC = observer(() => {
  const {
    sessionData: { user },
  } = useRootContext()
  const { order, setStep, verify, setVerify, verified } = useCartContext()
  const t = useTranslations('Cart.Checkout')
  const {
    register,
    handleSubmit,
    control,
    setError,
    watch,
    formState: { errors, isSubmitting },
  } = useForm<Values>({
    defaultValues: {
      name: user.name,
      sname: user.sname,
      email: user.email,
      phone: user.phone,
      comment: order?.comment,
    },
  })

  const onSubmit: SubmitHandler<Values> = async (data) => {
    try {
      await axios.post('/cart/checkout', data)
      setStep('delivery')
    } catch ({
      response: {
        status,
        data: { errors: errorsData },
      },
    }) {
      if (status === 403) {
        setVerify(true)
      } else if (status === 422) {
        entries(errorsData as Record<keyof Values, string[]>).forEach(([name, messages]) => {
          messages.map((message) => setError(name, { type: 'manual', message }))
        })
      }
    }
  }

  const watchPhone = watch('phone')
  const handleCloseCodeModal = (): void => setVerify(false)

  useEffect(() => {
    if (verified) {
      setVerify(false)
      void handleSubmit(onSubmit)()
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [verified])

  return (
    <div>
      <form onSubmit={handleSubmit(onSubmit)}>
        <div className={sf.el}>
          <h2 className={cc([s.header, s.sp])}>{t('title')}</h2>

          <label className={sf.it}>
            <div className={sf.lb}>{t('name')}</div>
            <input className={sf.in} type="text" {...register('name')} />
          </label>

          {errors.name != null && <div className={sf.er}>{errors.name.message}</div>}
        </div>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>{t('sname')}</div>
            <input className={sf.in} type="text" {...register('sname')} />
          </label>

          {errors.sname != null && <div className={sf.er}>{errors.sname.message}</div>}
        </div>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>{t('email')}</div>
            <input className={sf.in} type="text" {...register('email')} />
          </label>

          {errors.email != null && <div className={sf.er}>{errors.email.message}</div>}
        </div>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>{t('phone')}</div>

            <Controller
              control={control}
              name="phone"
              render={({ field }) => (
                <Cleave
                  className={sf.in}
                  {...field}
                  type="tel"
                  options={{
                    numeral: true,
                    prefix: '+',
                    numeralThousandsGroupStyle: 'none',
                  }}
                />
              )}
            />
            {/* <input className={sf.in} type="text" {...register('phone')} /> */}
          </label>

          {errors.phone != null && <div className={sf.er}>{errors.phone.message}</div>}
        </div>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>{t('comment')}</div>
            <textarea className={sf.in} {...register('comment')} />
          </label>
        </div>

        <div>
          <button className={cc([sb.main, { [sb.submitting]: isSubmitting }])} disabled={isSubmitting} type="submit">
            {t('submit')}
          </button>
        </div>
      </form>

      <Modal className={s.modal} overlayClassName={s.overlay} isOpen={verify} onRequestClose={handleCloseCodeModal}>
        <div className={s.close} onClick={handleCloseCodeModal}>
          <svg viewBox="0 0 16 16">
            <line x1="1" y1="1" x2="15" y2="15" />
            <line x1="1" y1="15" x2="15" y2="1" />
          </svg>
        </div>

        <CodeModal phone={watchPhone} />
      </Modal>
    </div>
  )
})
