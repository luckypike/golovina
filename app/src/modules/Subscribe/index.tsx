import { FC } from "react";
import { useTranslations } from "next-intl";
import Head from "next/head";
import { SubmitHandler, useForm } from "react-hook-form";

import s from './index.module.css'
import sf from '../../layout/form.module.css'
import { entries } from "../../models";
import axios from "axios";

type Values = {
  email: string
  first_name: string
  last_name: string
  date_of_birth: string
}

export const Subscribe: FC = () => {
  const {
    register,
    handleSubmit,
    setValue,
    setError,
    formState: { errors },
  } = useForm<Values>()
  const t = useTranslations('Subscribe');

  const onSubmit: SubmitHandler<Values> = async (data) => {
    console.log(data)

    try {
      await axios.post('/subscriptions', data)
    } catch ({ response: { data: { errors: errorsData } } }) {
      entries(errorsData as Record<keyof Values, string[]>).forEach(([name, messages]) => {
        messages.map(message => setError(name, { type: 'manual', message }))
      })
    }
  }

  return (
    <div className={s.root}>
      <Head>
        <title>{t('title')}</title>
      </Head>


      <div className={s.main}>
        <form onSubmit={handleSubmit(onSubmit)} className={sf.root} noValidate>
          <div className={sf.el}>
            <label className={sf.it}>
              <div className={sf.lb}>{t('email')}</div>
              <input className={sf.in} type="email" {...register('email')} />
            </label>

            {errors.email && <div className={sf.er}>{errors.email.message}</div>}
          </div>

          <div className={sf.el}>
            <label className={sf.it}>
              <div className={sf.lb}>{t('first_name')}</div>
              <input className={sf.in} type="text" {...register('first_name')} />
            </label>

            {errors.first_name && <div className={sf.er}>{errors.first_name.message}</div>}
          </div>

          <div className={sf.el}>
            <label className={sf.it}>
              <div className={sf.lb}>{t('last_name')}</div>
              <input className={sf.in} type="text" {...register('last_name')} />
            </label>

            {errors.last_name && <div className={sf.er}>{errors.last_name.message}</div>}
          </div>

          <div className={sf.el}>
            <label className={sf.it}>
              <div className={sf.lb}>{t('date_of_birth')}</div>
              <input className={sf.in} type="date" {...register('date_of_birth')} />
            </label>

            {errors.date_of_birth && <div className={sf.er}>{errors.date_of_birth.message}</div>}
          </div>

          <div>
            <button type="submit">{t('subscribe')}</button>
          </div>
        </form>
      </div>
    </div>
  )
}
