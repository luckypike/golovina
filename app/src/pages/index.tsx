import axios from 'axios'
import type { GetServerSideProps, NextPage } from 'next'
import Link from 'next/link'
import { useRouter } from 'next/router'

const IndexPage: NextPage = () => {
  const router = useRouter()

  return (
    <div>
      <main>INDEX</main>

      <p>
        <Link href="/about">About</Link>
        <button onClick={() => router.push({ pathname: '/about' })}>push to about</button>
      </p>
    </div>
  )
}

// export const getServerSideProps: GetServerSideProps = async (context) => {
//   // const { cookie } = context.req.headers
//   // console.log(axios.defaults.headers.common.Cookie)
//   // console.log('IND')

//   // const { data } = await axios.get('/session')

//   // console.log(data)

//   return {
//     props: {},
//   }
// }

export default IndexPage
