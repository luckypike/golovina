import axios from 'axios'
import { useRouter } from 'next/router'
import { FC, useEffect, useState } from 'react'
import { SubmitHandler, useForm } from 'react-hook-form'
import { entries } from '../../models'
import cc from 'classcat'

import s from './index.module.css'
import sf from '../../layout/form.module.css'
import { ImagesDropzone } from '../ImagesDropzone'
import { ImagesDropzoneStore } from '../ImagesDropzone/store'

interface Values {
  category_id: number
  color_id: number
  theme_ids: number[]
  state: string
  title_ru: string
  title_en: string
  desc_ru: string
  desc_en: string
  comp_ru: string
  comp_en: string
  code: string
  price: number
  price_last: number
  published_at: Date
  images: Array<{
    id: number
    key: string
    src: string
    weight: number
    active: boolean
  }>
}

interface Dic {
  states: Array<{ id: number; title: string }>
  themes: Array<{ id: number; title: string }>
  colors: Array<{ id: number; title: string; parent_color_id?: number }>
  categories: Array<{ id: number; title: string }>
}

interface FormData {
  values: Values
  dic: Dic
}

export const VariantsForm: FC = () => {
  const router = useRouter()
  const {
    register,
    handleSubmit,
    setValue,
    setError,
    formState: { errors },
  } = useForm<Values>()
  const [dic, setDic] = useState<Dic>()
  const { id, product_id: productId } = router.query
  const [store] = useState(() => new ImagesDropzoneStore())

  useEffect(() => {
    const _fetch = async (): Promise<void> => {
      const { data } = id
        ? // eslint-disable-next-line @typescript-eslint/restrict-template-expressions
          await axios.get<FormData>(`/variants/${id}/edit`)
        : await axios.get<FormData>('/variants/new', {
            params: { product_id: productId },
          })
      entries(data.values).forEach(([key, value]) => setValue(key, value))
      setDic(data.dic)
      store.addImages(data.values.images)
    }

    void _fetch()
  }, [id, productId])

  const onSubmit: SubmitHandler<Values> = async (data) => {
    data = { ...data, images: store.toParams }

    try {
      // eslint-disable-next-line @typescript-eslint/restrict-template-expressions
      id ? await axios.put(`/variants/${id}`, data) : await axios.post('/variants', { ...data, product_id: productId })
      window.location.href = '/dashboard/catalog'
    } catch ({
      response: {
        data: { errors: errorsData },
      },
    }) {
      entries(errorsData as Record<keyof Values, string[]>).forEach(([name, messages]) => {
        messages.map((message) => setError(name, { type: 'manual', message }))
      })
    }
  }

  if (dic == null) return null

  return (
    <div className={s.root}>
      <div className={s.title}>
        <h1>Новый продукт</h1>
      </div>

      <form onSubmit={handleSubmit(onSubmit)} className={sf.root}>
        <div className={sf.el}>
          <div className={sf.it}>
            <div className={sf.lb}>Статус</div>
            {dic.states.map((state) => (
              <label key={state.id} className={cc([sf.lb, sf.radio])}>
                <input {...register('state')} type="radio" value={state.id} />
                {state.title}
              </label>
            ))}
          </div>

          {errors.state != null && <div className={sf.er}>{errors.state.message}</div>}
        </div>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>Название * (RU)</div>
            <input className={sf.in} {...register('title_ru')} />
          </label>

          {errors.title_ru != null && <div className={sf.er}>{errors.title_ru.message}</div>}
        </div>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>Категория *</div>
            <select className={sf.in} {...register('category_id')}>
              <option disabled value="" />
              {dic.categories.map((category) => (
                <option key={category.id} value={category.id}>
                  {category.title}
                </option>
              ))}
            </select>
          </label>

          {errors.category_id != null && <div className={sf.er}>{errors.category_id.message}</div>}
        </div>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>Тема</div>

            {dic.themes.map((theme) => (
              <label key={theme.id} className={cc([sf.lb, sf.checkbox])}>
                <input {...register('theme_ids')} type="checkbox" value={theme.id} />
                {theme.title}
              </label>
            ))}
          </label>

          {errors.category_id != null && <div className={sf.er}>{errors.category_id.message}</div>}
        </div>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>Цвет *</div>
            <select className={sf.in} {...register('color_id')}>
              <option disabled value="" />
              {dic.colors
                .filter((c) => c.parent_color_id !== undefined)
                .map((color) => (
                  <optgroup key={color.id} label={color.title}>
                    {dic.colors
                      .filter((c) => c.parent_color_id === color.id)
                      .map((subColor) => (
                        <option key={subColor.id} value={subColor.id}>
                          {subColor.title} #{subColor.id}
                        </option>
                      ))}
                  </optgroup>
                ))}
            </select>
          </label>

          {errors.color_id != null && <div className={sf.er}>{errors.color_id.message}</div>}
        </div>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>Описание</div>
            <textarea className={sf.in} {...register('desc_ru')} />
          </label>

          {errors.desc_ru != null && <div className={sf.er}>{errors.desc_ru.message}</div>}
        </div>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>Состав</div>
            <textarea className={sf.in} {...register('comp_ru')} />
          </label>

          {errors.comp_ru != null && <div className={sf.er}>{errors.comp_ru.message}</div>}
        </div>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>Артикул</div>
            <input className={sf.in} {...register('code')} />
          </label>

          {errors.code != null && <div className={sf.er}>{errors.code.message}</div>}
        </div>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>Стоимость</div>
            <input className={sf.in} {...register('price')} />
          </label>

          {errors.price != null && <div className={sf.er}>{errors.price.message}</div>}
        </div>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>Стоимость со скидкой</div>
            <input className={sf.in} {...register('price_last')} />
          </label>

          {errors.price_last != null && <div className={sf.er}>{errors.price_last.message}</div>}
        </div>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>Дата публикации</div>
            <input className={sf.in} {...register('published_at')} />
          </label>

          {errors.published_at != null && <div className={sf.er}>{errors.published_at.message}</div>}
        </div>

        <div>
          <ImagesDropzone store={store} />
        </div>

        <div className={sf.sb}>
          <div className={sf.sbt}>
            <h2>Локализация (EN)</h2>
          </div>

          <div className={sf.el}>
            <label className={sf.it}>
              <div className={sf.lb}>Название (EN)</div>
              <input className={sf.in} {...register('title_en')} />
            </label>

            {errors.title_en != null && <div className={sf.er}>{errors.title_en.message}</div>}
          </div>

          <div className={sf.el}>
            <label className={sf.it}>
              <div className={sf.lb}>Описание (EN)</div>
              <input className={sf.in} {...register('desc_en')} />
            </label>

            {errors.desc_en != null && <div className={sf.er}>{errors.desc_en.message}</div>}
          </div>

          <div className={sf.el}>
            <label className={sf.it}>
              <div className={sf.lb}>Состав (EN)</div>
              <input className={sf.in} {...register('comp_en')} />
            </label>

            {errors.comp_en != null && <div className={sf.er}>{errors.comp_en.message}</div>}
          </div>
        </div>

        <div>
          <button type="submit">Save</button>
        </div>
      </form>
    </div>
  )
}
