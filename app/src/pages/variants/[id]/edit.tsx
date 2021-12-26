import axios from 'axios';
import type { GetServerSideProps, NextPage } from 'next'
import Link from 'next/link'
import { useRouter } from 'next/router'
import { useEffect } from 'react'
import { useForm, SubmitHandler } from "react-hook-form";
import { entries } from '../../../models';

type Inputs = {
  title_ru: string,
  title_en: string,
  desc_ru: string,
  desc_en: string
};

const VariantsEditPage: NextPage = () => {
  const router = useRouter()
  const { register, handleSubmit, setValue, watch, formState: { errors } } = useForm<Inputs>();
  const { id } = router.query

  useEffect(() =>  {
    const _fetch = async (): Promise<void> => {
      const { data } = await axios.get<Inputs>(`/variants/${id}/edit`);
      entries(data).forEach(([key, value]) => setValue(key, value))
    }

    _fetch()
  }, [id])

  const onSubmit: SubmitHandler<Inputs> = async(data) => {
    try {
      await axios.patch(`/variants/${id}`, data)
    } catch ({ response: { data } }) {
      console.log(data)
    }
  }

  return (
    <div>
      EDIT VARIANT {id}

      <div>
        <form onSubmit={handleSubmit(onSubmit)}>
          <input {...register("title_ru")} />
          <input {...register("title_en")} />
          <input {...register("desc_ru")} />
          <input {...register("desc_en")} />

          <button type="submit">
            Save
          </button>
        </form>
      </div>
    </div>
  )
}

// export const getServerSideProps: GetServerSideProps = async (context) => {
//   return {
//     props: {}
//   }
// }

export default VariantsEditPage
