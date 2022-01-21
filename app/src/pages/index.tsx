import axios from 'axios'
import type { GetServerSideProps, NextPage } from 'next'
import Link from 'next/link'
import { useRouter } from 'next/router'
import { Index } from '../modules/Index'

const IndexPage: NextPage = () => {
  return (
    <Index />
  )
}

export const getServerSideProps: GetServerSideProps = async (context) => {
  const { data } = await axios.get('/pages/index')

  console.log(data)

  return {
    props: {},
  }
}

export default IndexPage
