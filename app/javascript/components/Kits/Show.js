import React, { useEffect, useState } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

import { path } from '../Routes'
import List from './List'

import page from '../Page'

Show.propTypes = {
  id: PropTypes.number
}

export default function Show (props) {
  const [kit, setKit] = useState()

  useEffect(() => {
    const _loadAsyncData = async () => {
      const { data: { kit } } = await axios.get(path('kit_path', { id: props.id, format: 'json' }))
      setKit(kit)
    }

    _loadAsyncData()
  }, [])

  return (
    <div className={page.root}>
      <div>
        {kit &&
          <List kits={[kit]} />
        }
      </div>
    </div>
  )
}
