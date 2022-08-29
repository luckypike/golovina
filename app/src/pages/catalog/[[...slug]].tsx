import type { GetServerSideProps, NextPage } from 'next'
import { useEffect, useState } from 'react'

import { Catalog, getCatalogData } from '../../modules/Catalog'
import { CatalogContext } from '../../modules/Catalog/context'
import { CatalogData } from '../../modules/Catalog/data'
import { CatalogStore } from '../../modules/Catalog/store'

const CatalogPage: NextPage<{ data: CatalogData }> = ({ data }) => {
  const [store] = useState(new CatalogStore(data.variants, data.entity))

  useEffect(() => {
    store.setVariants(data.variants)
    store.setEntity(data.entity)
  }, [data])

  return (
    <CatalogContext.Provider value={store}>
      <Catalog />
    </CatalogContext.Provider>
  )
}

export const getServerSideProps: GetServerSideProps = async (context) => {
  const slug = context.params?.slug?.[0]

  try {
    const catalogData = await getCatalogData(slug, context.locale)

    return {
      props: { data: catalogData },
    }
  } catch {
    return {
      notFound: true,
    }
  }
}

export default CatalogPage
