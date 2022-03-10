import { FC, useEffect, useState } from "react";
import { observer } from "mobx-react-lite";
import Select from 'react-select'
import { useTranslations } from "next-intl";
import { SubmitHandler, useForm } from "react-hook-form";
import axios from "axios";
import cc from 'classcat'
import { entries } from "../../../models";

import s from './index.module.css'
import sf from '../../../layout/form.module.css'
import sb from '../../../css/buttons.module.css'
import { useCartContext } from "../context";
import { DeliveryCityData, WatchDeliveryOption } from "../models";
import { Summary } from "./Summary";

type Values = {
  delivery: string
  delivery_city_id: number
  delivery_option: string
  zip: string
  country: string
  city: string
  street: string
  house: string
  appartment: string
}

export const Delivery: FC = observer(() => {
  const t = useTranslations('Cart.Delivery');
  const { order, setStep, setReload } = useCartContext()
  const {
    register,
    handleSubmit,
    setValue,
    control,
    clearErrors,
    watch,
    setError,
    formState: { errors, isSubmitting },
  } = useForm<Values>()

  const onSubmit: SubmitHandler<Values> = async (data) => {
    try {
      await axios.post('/cart/delivery', data)
      setReload(true)
      setStep('pay')
    } catch ({ response: { data: { errors: errorsData } } }) {
      entries(errorsData as Record<keyof Values, string[]>).forEach(([name, messages]) => {
        messages.map(message => setError(name, { type: 'manual', message }))
      })
    }
  }

  const watchDelivery = watch('delivery')
  const watchDeliveryCityId = watch('delivery_city_id')
  const watchDeliveryOption = watch('delivery_option')

  useEffect(() => {
    setValue('zip', '')
    setValue('street', '')
    setValue('house', '')
    setValue('appartment', '')
    setValue('city', '')
    setValue('country', '')
    clearErrors()
  }, [watchDelivery, clearErrors, setValue])

  const [cities, setCities] = useState<DeliveryCityData[]>([])
  useEffect(() => {
    const _fetch = async () => {
      const { data } = await axios.get<DeliveryCityData[]>('/delivery_cities')
      setCities(data)
    }

    _fetch()
  }, [])

  const [deliveryOptions, setDeliveryOption] = useState<WatchDeliveryOption[]>([])

  return (
    <div>
      <form onSubmit={handleSubmit(onSubmit)}>
        <div className={sf.el}>
          <h2 className={s.header}>
            {t('title')}
          </h2>

          <div
            className={cc([s.delivery, { [s.active]: watchDelivery === 'pickup' }])}
            onClick={() => { setValue('delivery', 'pickup')}}
          >
            <strong>
              {t('pickup.title')}
            </strong>

            <div className={s.desc}>
              {t('pickup.desc')}
            </div>
          </div>

          <div
            className={cc([s.delivery, { [s.active]: watchDelivery === 'russia' }])}
            onClick={() => { setValue('delivery', 'russia')}}
          >
            <strong>
              {t('russia.title')}
            </strong>

            <div className={s.desc}>
              {t('russia.desc')}
            </div>
          </div>

          <div
            className={cc([s.delivery, { [s.active]: watchDelivery === 'international' }])}
            onClick={() => { setValue('delivery', 'international')}}
          >
            <strong>
              {t('international.title')}
            </strong>

            <div className={s.desc}>
              {t('international.desc')}
            </div>
          </div>

          {errors.delivery && <div className={sf.er}>{errors.delivery.message}</div>}
        </div>

        {watchDelivery === 'international' &&
          <>
            <div className={sf.el}>
              <h2 className={cc([s.header, s.sp])}>
                {t('address')}
              </h2>

              <label className={sf.it}>
                <div className={sf.lb}>{t('country')}</div>
                <input className={sf.in} type="text" {...register('country')} />
              </label>

              {errors.country && <div className={sf.er}>{errors.country.message}</div>}
            </div>

            <div className={sf.el}>
              <label className={sf.it}>
                <div className={sf.lb}>{t('city')}</div>
                <input className={sf.in} type="text" {...register('city')} />
              </label>

              {errors.city && <div className={sf.er}>{errors.city.message}</div>}
            </div>
          </>
        }

        {watchDelivery == 'russia' &&
          <>
            <div className={sf.el}>
              <h2 className={cc([s.header, s.sp])}>
                {t('address')}
              </h2>

              <label className={sf.it}>
                <div className={sf.lb}>{t('delivery_city_id')}</div>

                <Select
                  classNamePrefix="golovina-select"
                  options={cities}
                  getOptionLabel={(option) => option.title}
                  getOptionValue={(option) => option.id.toString()}
                  onChange={(option) => {
                    console.log(option)

                    if(option){
                      setValue('delivery_city_id', option.id)
                      clearErrors('delivery_city_id')

                      let temp_delivery_options: WatchDeliveryOption[] = []

                      if (option.door_days && option.door) {
                        temp_delivery_options.push({
                          id: 'door',
                          title: t('delivery_option.door', { days: option.door_days }),
                          price: option.door
                        })
                      }

                      if (option.storage_days && option.storage) {
                        temp_delivery_options.push({
                          id: 'storage',
                          title: t('delivery_option.storage', { days: option.storage_days }),
                          price: option.storage
                        })
                      }

                      setDeliveryOption(temp_delivery_options)
                    } else {
                      setDeliveryOption([])
                      setValue('delivery_city_id', 0)
                    }
                    setValue('delivery_option', '')
                  }}
                />
              </label>

              {errors.delivery_city_id && <div className={sf.er}>{errors.delivery_city_id.message}</div>}
            </div>

            <div className={sf.el}>
              {deliveryOptions.map((delivery_option) => (
                <label key={delivery_option.id} className={cc([sf.lb, sf.checkbox])}>
                  <input {...register("delivery_option")} type="radio" value={delivery_option.id} />
                  {delivery_option.title}
                </label>
              ))}

              {errors.delivery_option && !errors.delivery_city_id && <div className={sf.er}>{errors.delivery_option.message}</div>}
            </div>
          </>
        }

        {(watchDelivery === 'russia' || watchDelivery === 'international') &&
          <>
            <div className={sf.el}>
              <label className={sf.it}>
                <div className={sf.lb}>{t('zip')}</div>
                <input className={sf.in} type="text" {...register('zip')} />
              </label>

              {errors.zip && <div className={sf.er}>{errors.zip.message}</div>}
            </div>

            <div className={sf.el}>
              <label className={sf.it}>
                <div className={sf.lb}>{t('street')}</div>
                <input className={sf.in} type="text" {...register('street')} />
              </label>

              {errors.street && <div className={sf.er}>{errors.street.message}</div>}
            </div>

            <div className={s.row}>
              <div className={sf.el}>
                <label className={sf.it}>
                  <div className={sf.lb}>{t('house')}</div>
                  <input className={sf.in} type="text" {...register('house')} />
                </label>

                {errors.house && <div className={sf.er}>{errors.house.message}</div>}
              </div>

              <div className={sf.el}>
                <label className={sf.it}>
                  <div className={sf.lb}>{t('appartment')}</div>
                  <input className={sf.in} type="text" {...register('appartment')} />
                </label>

                {errors.appartment && <div className={sf.er}>{errors.appartment.message}</div>}
              </div>
            </div>
          </>
        }

        <div className={s.summary}>
          <Summary watchDelivery={watchDelivery} deliveryOption={deliveryOptions.find(i => i.id === watchDeliveryOption)} />
        </div>

        <div>
          <button className={sb.main} disabled={isSubmitting} type="submit">{t('submit')}</button>
        </div>
      </form>
    </div>
  )
})
