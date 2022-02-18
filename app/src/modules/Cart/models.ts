export interface CartData {
  order: OrderData
  order_items: OrderItemData[]
}

export interface OrderData {
  id: number
}

export interface OrderItemData {
  id: number
  variant: {
    title: string
  }
}
