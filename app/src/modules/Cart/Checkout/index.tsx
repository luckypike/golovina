import { FC, useEffect } from "react";
import { observer } from "mobx-react-lite";
import axios from "axios";
import { Controller, SubmitHandler, useForm, useWatch } from "react-hook-form";
import { useTranslations } from "next-intl";
import cc from 'classcat'

import { useCartContext } from "../context";

import s from './index.module.css'
import sf from '../../../layout/form.module.css'
import sb from '../../../css/buttons.module.css'
import { entries } from "../../../models";
import Cleave from "cleave.js/react";
import { useRootContext } from "../../../services/useRootContext";

type Values = {
  name: string
  sname: string
  email: string
  phone: string
  comment: string
}

export const Checkout: FC = observer(() => {
  const { sessionData: { user } }  = useRootContext()
  const { order, setStep } = useCartContext()
  const t = useTranslations('Cart.Checkout');
  const {
    register,
    handleSubmit,
    control,
    setError,
    formState: { errors },
  } = useForm<Values>({
    defaultValues: {
      name: user.name,
      sname: user.sname,
      email: user.email,
      phone: user.phone,
      comment: order?.comment,
    }
  })

  const onSubmit: SubmitHandler<Values> = async (data) => {
    try {
      await axios.post('/cart/checkout', data)
      setStep('delivery')
    } catch ({ response: { data: { errors: errorsData } } }) {
      entries(errorsData as Record<keyof Values, string[]>).forEach(([name, messages]) => {
        messages.map(message => setError(name, { type: 'manual', message }))
      })
    }
  }

  return (
    <div>
      <form onSubmit={handleSubmit(onSubmit)}>
        <div className={sf.el}>
          <h2 className={cc([s.header, s.sp])}>
            {t('title')}
          </h2>

          <label className={sf.it}>
            <div className={sf.lb}>{t('name')}</div>
            <input className={sf.in} type="text" {...register('name')} />
          </label>

          {errors.name && <div className={sf.er}>{errors.name.message}</div>}
        </div>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>{t('sname')}</div>
            <input className={sf.in} type="text" {...register('sname')} />
          </label>

          {errors.sname && <div className={sf.er}>{errors.sname.message}</div>}
        </div>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>{t('email')}</div>
            <input className={sf.in} type="text" {...register('email')} />
          </label>

          {errors.email && <div className={sf.er}>{errors.email.message}</div>}
        </div>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>{t('phone')}</div>

            <Controller
              control={control}
              name="phone"
              render={({ field }) => <Cleave className={sf.in} {...field} type="tel" options={{ numeral: true, prefix: '+', numeralThousandsGroupStyle: 'none' }} />}
            />
            {/* <input className={sf.in} type="text" {...register('phone')} /> */}
          </label>

          {errors.phone && <div className={sf.er}>{errors.phone.message}</div>}
        </div>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>{t('comment')}</div>
            <textarea className={sf.in} {...register('comment')} />
          </label>
        </div>

        <div>
          <button className={sb.main} type="submit">{t('submit')}</button>
        </div>
      </form>
    </div>
  )
})
