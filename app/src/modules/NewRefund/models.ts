import { NestedValue } from 'react-hook-form'

export interface OrderData {
  id: number
  amount: number
  paid_at_fancy: string
  order_items: OrderItemData[]
}

export interface OrderItemData {
  id: number
  refunded: boolean
  size: {
    id: number
    title: string
  }
  variant: {
    title: string
    color: {
      id: number
      title: string
    }
    image?: {
      id: number
      src: string
    }
  }
}

export interface Values {
  order_id: number | ''
  reason: 'size' | 'defect' | 'color' | 'other' | ''
  detail: string
  order_item_ids: NestedValue<number[]>
}
