import axios from 'axios'
import type { GetServerSideProps, NextPage } from 'next'
import Link from 'next/link'
import { useEffect } from 'react'

const AboutPage: NextPage = () => {
  // useEffect(() => {
  //   const _q = async () => {
  //     const { data } = await axios.get('/pages/index')

  //     console.log(data)
  //   }

  //   console.log(axios.defaults.baseURL)
  //   _q()
  // }, [])

  return (
    <div>
      <main>ABOUT</main>

      <p>
        <Link href="/">Index</Link>
      </p>
    </div>
  )
}

// export const getServerSideProps: GetServerSideProps = async (context) => {
//   return {
//     props: {},
//   }
// }

export default AboutPage
