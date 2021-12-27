import axios from 'axios'
import type { GetServerSideProps, NextPage } from 'next'
import Link from 'next/link'

const IndexPage: NextPage = () => {
  return (
    <div>
      <main>INDEX</main>

      <p>
        <Link href="/about">About</Link>
      </p>
    </div>
  )
}

export const getServerSideProps: GetServerSideProps = async (context) => {
  // const { cookie } = context.req.headers
  // console.log(axios.defaults.headers.common.Cookie)
  // console.log('IND')

  // const { data } = await axios.get('/session')

  // console.log(data)

  return {
    props: {},
  }
}

export default IndexPage
