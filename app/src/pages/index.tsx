import axios from 'axios'
import type { GetServerSideProps, NextPage } from 'next'
import Head from 'next/head'
import Link from 'next/link'
import { useRouter } from 'next/router'
import { useEffect, useState } from 'react'
import { getIndexData, Index } from '../modules/Index'
import { IndexContext } from '../modules/Index/context'
import { IndexData } from '../modules/Index/models'
import { IndexStore } from '../modules/Index/store'
import { useRootContext } from '../services/useRootContext'

const IndexPage: NextPage<{ data: IndexData }> = ({ data }) => {
  const [store] = useState(() => new IndexStore(data))
  const rootStore = useRootContext()

  useEffect(() => {
    rootStore.setHeaderInvert(true)

    return () => {
      rootStore.setHeaderInvert(false)
    }
  }, [rootStore])

  return (
    <IndexContext.Provider value={store}>
      <Head>
        <title>GOLOVINA MARI — The whole world in you</title>
      </Head>

      <Index />
    </IndexContext.Provider>
  )
}

export const getServerSideProps: GetServerSideProps = async (context) => {
  const indexData = await getIndexData()

  return {
    props: { data: indexData }
  }
}

export default IndexPage
