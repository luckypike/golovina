import { makeAutoObservable } from 'mobx'
import { CartData, OrderData, OrderItemData } from './models'

export class CartStore {
  order?: OrderData = undefined
  order_items: OrderItemData[] = []

  constructor() {
    makeAutoObservable(this)
  }

  setData = (data: CartData) => {
    this.order = data.order
    this.order_items = data.order_items
  }
}
