import type { GetServerSideProps, NextPage } from 'next'
import Link from 'next/link'

const AboutPage: NextPage = () => {
  return (
    <div>
      <main>
        ABOUT
      </main>

      <p>
        <Link href="/">Index</Link>
      </p>
    </div>
  )
}

export const getServerSideProps: GetServerSideProps = async (context) => {
  return {
    props: {}
  }
}

export default AboutPage
