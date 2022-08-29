import { makeAutoObservable } from 'mobx'
import { CatalogEntityData, CatalogVariantData } from './data'

export class CatalogStore {
  variants: CatalogVariantData[]
  entity: CatalogEntityData
  init = false

  constructor(variants: CatalogVariantData[], entity: CatalogEntityData) {
    this.variants = variants
    this.entity = entity
    this.init = true

    makeAutoObservable(this)
  }

  setVariants = (variants: CatalogVariantData[]) => {
    this.variants = variants
  }

  setEntity = (entity: CatalogEntityData) => {
    this.entity = entity
  }
}
