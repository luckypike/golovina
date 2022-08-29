export interface CatalogData {
  entity: CatalogEntityData
  variants: CatalogVariantData[]
}

export interface CatalogVariantData {
  id: number
  title: string
  label?: string
  category: {
    id: number
    slug: string
  }
  images: CatalogVariantImageData[]
  state: number
  price_sell?: number
  price?: number
  published_at: string
  colors: number
  wishlist: boolean
}

export interface CatalogEntityData {
  title: string
}

export interface CatalogVariantImageData {
  id: number
  key: string
}
