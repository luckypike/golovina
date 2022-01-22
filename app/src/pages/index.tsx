import axios from 'axios'
import type { GetServerSideProps, NextPage } from 'next'
import Link from 'next/link'
import { useRouter } from 'next/router'
import { useEffect, useState } from 'react'
import { getIndexData, Index } from '../modules/Index'
import { IndexContext } from '../modules/Index/context'
import { IndexData } from '../modules/Index/models'
import { IndexStore } from '../modules/Index/store'

const IndexPage: NextPage<{ data: IndexData }> = ({ data }) => {
  const [store] = useState(() => new IndexStore(data))

  return (
    <IndexContext.Provider value={store}>
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
